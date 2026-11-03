import SwiftUI
import AppKit

// UI lifecycle, compact progress/error presentation and folder selection are
// adapted from the native Stardew installer. Forest owns the language picker,
// resource adapter and isolated game-copy transaction.
@main
struct ForestLanguagesApp: App {
    @StateObject private var state = AppState()
    var body: some Scene {
        WindowGroup("The Forest of Love — Languages") {
            ContentView(state: state).frame(width: 520, height: 460)
        }.windowResizability(.contentSize)
    }
}

@MainActor
final class AppState: ObservableObject {
    @Published var selected = "ru"
    @Published private(set) var busy = false
    @Published private(set) var message = "Choose a language and prepare your game copy."
    @Published private(set) var failed = false
    @Published private(set) var source: URL?
    @Published private(set) var active: String?
    private var core: InstallerCore?
    private var runningGame: GameSession?
    var locales: [LocaleLabel] { core?.config.locales ?? [] }
    var canLaunch: Bool { active == selected && !busy && runningGame?.process.isRunning != true }
    init() {
        do {
            guard let resources = Bundle.main.resourceURL else { throw ForestError("App resources are missing") }
            let config = try JSONDecoder().decode(PackageConfig.self, from: Data(contentsOf: resources.appendingPathComponent("PackageConfig.json")))
            let core = InstallerCore(root: InstallerCore.support, resources: resources, config: config)
            self.core = core
            source = core.detect()
            let state = core.currentState(); active = state?.locale
            if let locale = state?.locale { selected = locale }
            if source == nil, let path = state?.source { source = core.resolve(URL(fileURLWithPath: path)) }
            if source == nil { message = "Choose the original macOS game app to continue." }
            else if state != nil { message = "Your game copy is ready. Choose a language or launch it." }
        } catch { failed = true; message = error.localizedDescription }
    }
    func chooseGame() {
        guard !busy, let core else { return }
        let panel = NSOpenPanel()
        panel.title = "Choose The Forest of Love"
        panel.message = "Select the original macOS game app or its containing folder."
        panel.prompt = "Choose"; panel.canChooseFiles = true; panel.canChooseDirectories = true
        panel.treatsFilePackagesAsDirectories = false; panel.allowsMultipleSelection = false
        guard panel.runModal() == .OK, let url = panel.url else { return }
        guard let found = core.resolve(url) else {
            failed = true; message = "The selected folder does not contain the macOS game."; return
        }
        source = found; failed = false; message = "Choose a language, then click Apply language."
    }
    func gameIsRunning() -> Bool {
        runningGame?.process.isRunning == true || !NSRunningApplication.runningApplications(withBundleIdentifier: "com.CarrotsCrittersVulpineVisions.TheForestofLove").isEmpty
    }
    func apply() {
        guard !busy, let core, let source else { return }
        guard !gameIsRunning() else { failed = true; message = "Quit The Forest of Love before changing its language."; return }
        busy = true; failed = false; message = "Verifying the original game…"
        let locale = selected
        Task { [self] in
            do {
                _ = try await Task.detached(priority: .userInitiated) { [weak self] in
                    try core.apply(source: source, locale: locale) { text in
                        Task { @MainActor [weak self] in if self?.busy == true { self?.message = text } }
                    }
                }.value
                active = locale; message = "Ready. Launch your localized game copy below."
            } catch { failed = true; message = error.localizedDescription; active = core.currentState()?.locale }
            busy = false
        }
    }
    func launch() {
        guard canLaunch, let core else { return }
        guard !gameIsRunning() else { failed = true; message = "The Forest of Love is already running."; return }
        // Verify the selected owned copy, then execute its native entry point.
        busy = true; failed = false; message = "Verifying the game copy…"
        let locale = selected
        Task { [self] in
            do {
                let game = try await Task.detached(priority: .userInitiated) { try core.verifyLaunch(expectedLocale: locale) }.value
                guard !gameIsRunning() else { throw ForestError("The Forest of Love is already running.") }
                let session = try GameLauncher.start(game: game, logs: core.root.appendingPathComponent("Logs")) { [weak self] ended, log in
                    Task { @MainActor [weak self] in
                        guard let self, self.runningGame?.process === ended else { return }
                        self.runningGame = nil
                        self.failed = ended.terminationStatus != 0
                        self.message = ended.terminationStatus == 0 ? "The Forest of Love has closed." : "The game exited with code \(ended.terminationStatus). Log: \(log.path)"
                    }
                }
                runningGame = session
                busy = false; message = "The Forest of Love is running."
            } catch {
                busy = false; failed = true; message = error.localizedDescription
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var state: AppState
    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: state.failed ? "exclamationmark.triangle.fill" : "leaf.circle.fill")
                .font(.system(size: 54, weight: .semibold))
                .foregroundStyle(state.failed ? Color.orange : Color.green)
                .symbolEffect(.pulse, isActive: state.busy)
            Text("The Forest of Love").font(.system(size: 27, weight: .bold, design: .rounded))
            Picker("Game language", selection: $state.selected) {
                ForEach(state.locales) { locale in Text(locale.name).tag(locale.code) }
            }.disabled(state.busy).frame(maxWidth: 410)
            Text(state.source?.path ?? "Original game not found")
                .font(.caption).foregroundStyle(.secondary).lineLimit(2).textSelection(.enabled)
            ScrollView {
                Text(state.message).foregroundStyle(state.failed ? Color.red : Color.secondary)
                    .multilineTextAlignment(.center).textSelection(.enabled).frame(maxWidth: .infinity)
            }.frame(height: 58)
            if state.busy { ProgressView().progressViewStyle(.linear).frame(width: 340) }
            Spacer(minLength: 0)
            HStack {
                Button("Choose game…", action: state.chooseGame).disabled(state.busy)
                Button("Apply language", action: state.apply).disabled(state.busy || state.source == nil || state.locales.isEmpty)
                Button("Launch game", action: state.launch).buttonStyle(.borderedProminent)
                    .disabled(!state.canLaunch).keyboardShortcut(.defaultAction)
            }
            Text("27 languages + original English • Offline\nA separate game copy is used. The original stays untouched.")
                .font(.caption).foregroundStyle(.tertiary).multilineTextAlignment(.center)
        }.padding(28)
    }
}
