import Foundation
import CryptoKit
import Darwin
import AppKit

struct ForestError: LocalizedError {
    let text: String
    init(_ text: String) { self.text = text }
    var errorDescription: String? { text }
}
func require(_ condition: @autoclosure () throws -> Bool, _ message: String) throws {
    if try !condition() { throw ForestError(message) }
}
func sha256(_ data: Data) -> String { SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined() }
func fileSHA(_ url: URL) throws -> String {
    let stream = try FileHandle(forReadingFrom: url); defer { try? stream.close() }
    var hash = SHA256()
    while let data = try stream.read(upToCount: 1024 * 1024), !data.isEmpty { hash.update(data: data) }
    return hash.finalize().map { String(format: "%02x", $0) }.joined()
}
struct FilePin: Codable, Equatable, Sendable { let bytes: Int; let sha256: String }
struct Original: Codable, Sendable { let path: String; let bytes: Int; let sha256: String? }
struct BaseFile: Codable, Sendable { let path: String; let bytes: Int; let sha256: String }
struct Segment: Codable, Sendable { let base: Int; let offset: Int; let bytes: Int; let blob: String? }
struct LocalizedFile: Codable, Sendable {
    let path: String; let bytes: Int; let sha256: String
    let storageBytes: Int; let storageSha256: String; let segments: [Segment]; let bundle: Bool
}
struct ForestLocale: Codable, Identifiable, Sendable {
    let code: String; let name: String; let culture: String; let languageSha256: String; let files: [LocalizedFile]
    var id: String { code }
}
struct PayloadManifest: Codable, Sendable {
    let format: Int; let bundleID: String; let gameVersion: String
    let identityPath: String; let identitySha256: String; let bundlePath: String
    let originals: [Original]; let baselines: [BaseFile]; let locales: [ForestLocale]
}
struct PackageConfig: Codable, Sendable {
    let payloadSha256: String; let decodedSha256: String; let codecSha256: String
    let manifestSha256: String
    let locales: [LocaleLabel]
}
struct LocaleLabel: Codable, Identifiable, Sendable { let code: String; let name: String; var id: String { code } }
struct InstalledState: Codable, Sendable {
    let owner: String; let transaction: String; let locale: String; let source: String
    let payloadSha256: String; let files: [String: FilePin]
}
struct Transaction: Codable, Sendable { let owner: String; let id: String; let stage: String; let hadCurrent: Bool }

// The platform adapter is intentionally separate from the UI. No game process is
// started by preparation, installation, validation, recovery or English restore.
final class InstallerCore: @unchecked Sendable {
    static let owner = "org.vnrevival.forest.macos.v1"
    let root: URL
    let resources: URL
    let config: PackageConfig
    private let fm = FileManager.default
    private let failpoint: String?
    init(root: URL, resources: URL, config: PackageConfig, failpoint: String? = nil) {
        self.root = root; self.resources = resources; self.config = config; self.failpoint = failpoint
    }
    static var support: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("VN Revival/Forest", isDirectory: true)
    }
    var current: URL { root.appendingPathComponent("Current", isDirectory: true) }
    var game: URL { current.appendingPathComponent("The Forest of Love.app", isDirectory: true) }
    var codec: URL { resources.appendingPathComponent("forest-codec") }
    func run(_ executable: URL, _ args: [String]) throws -> String {
        let process = Process(); process.executableURL = executable; process.arguments = args
        let output = Pipe(); process.standardOutput = output; process.standardError = output
        try process.run()
        let data = output.fileHandleForReading.readDataToEndOfFile(); process.waitUntilExit()
        let text = String(decoding: data, as: UTF8.self)
        try require(process.terminationStatus == 0, "\(executable.lastPathComponent): \(text.prefix(1600))")
        return text
    }
    func safe(_ path: String, beneath base: URL) throws -> URL {
        try require(!path.isEmpty && !path.hasPrefix("/") && !path.contains("\\") && !path.split(separator: "/", omittingEmptySubsequences: false).contains(where: { $0 == ".." || $0 == "." || $0.isEmpty }), "Unsafe resource path")
        let result = base.appendingPathComponent(path)
        var cursor = base
        for component in path.split(separator: "/") {
            cursor.appendPathComponent(String(component))
            if let attributes = try? fm.attributesOfItem(atPath: cursor.path) {
                try require(attributes[.type] as? FileAttributeType != .typeSymbolicLink, "Resource escapes through a symbolic link: \(path)")
            }
        }
        try require(result.resolvingSymlinksInPath().path.hasPrefix(base.resolvingSymlinksInPath().path + "/"), "Resource escapes its folder: \(path)")
        return result
    }
    func check(_ url: URL, _ pin: FilePin) throws {
        let attributes = try fm.attributesOfItem(atPath: url.path)
        try require(attributes[.type] as? FileAttributeType == .typeRegular && (attributes[.size] as? NSNumber)?.intValue == pin.bytes && (try fileSHA(url)) == pin.sha256, "Resource differs: \(url.lastPathComponent). Choose an original Forest 0.45 installation.")
    }
    func write<T: Encodable>(_ value: T, to url: URL) throws {
        let encoder = JSONEncoder(); encoder.outputFormatting = [.sortedKeys]
        try encoder.encode(value).write(to: url, options: .atomic)
    }
    func locked<T>(_ operation: () throws -> T) throws -> T {
        try fm.createDirectory(at: root, withIntermediateDirectories: true)
        let fd = open(root.appendingPathComponent("installer.lock").path, O_CREAT | O_RDWR | O_NOFOLLOW | O_CLOEXEC, 0o600)
        try require(fd >= 0, "Cannot open installer lock"); defer { close(fd) }
        try require(flock(fd, LOCK_EX | LOCK_NB) == 0, "Another Forest installer is working. Wait for it to finish.")
        defer { flock(fd, LOCK_UN) }; return try operation()
    }
    func resolve(_ url: URL) -> URL? {
        let u = url.standardizedFileURL
        if fm.fileExists(atPath: u.appendingPathComponent("Contents/Resources/Data/Managed/Assembly-CSharp.dll").path) { return u }
        if let entries = try? fm.contentsOfDirectory(at: u, includingPropertiesForKeys: nil) {
            let matches = entries.filter { $0.pathExtension == "app" && fm.fileExists(atPath: $0.appendingPathComponent("Contents/Resources/Data/Managed/Assembly-CSharp.dll").path) }
            if matches.count == 1 { return matches[0] }
        }
        return nil
    }
    func detect() -> URL? {
        for url in [URL(fileURLWithPath: "/Applications/TheForestOfLove.app"), fm.homeDirectoryForCurrentUser.appendingPathComponent("Applications/TheForestOfLove.app")] {
            if let found = resolve(url) { return found }
        }
        return nil
    }
    func state(at folder: URL) throws -> InstalledState {
        let value = try JSONDecoder().decode(InstalledState.self, from: Data(contentsOf: folder.appendingPathComponent("state.json")))
        try require(value.owner == Self.owner && UUID(uuidString: value.transaction) != nil, "This folder is not owned by Forest Languages")
        return value
    }
    func currentState() -> InstalledState? { try? state(at: current) }
    func recover() throws {
        let journal = root.appendingPathComponent("transaction.json"), previous = root.appendingPathComponent("Previous")
        guard fm.fileExists(atPath: journal.path) else {
            try require(!fm.fileExists(atPath: previous.path), "Unclaimed Previous folder; preserve it and contact support."); return
        }
        let tx = try JSONDecoder().decode(Transaction.self, from: Data(contentsOf: journal))
        try require(tx.owner == Self.owner && UUID(uuidString: tx.id) != nil && tx.stage == "Stage-" + tx.id, "Invalid installation journal")
        let stage = try safe(tx.stage, beneath: root)
        if fm.fileExists(atPath: current.path) {
            let existing = try state(at: current)
            if existing.transaction == tx.id {
                if fm.fileExists(atPath: previous.path) { _ = try state(at: previous); try fm.removeItem(at: previous) }
            } else {
                try require(tx.hadCurrent && !fm.fileExists(atPath: previous.path), "Ambiguous interrupted installation; files preserved")
            }
        } else if fm.fileExists(atPath: previous.path) {
            _ = try state(at: previous); try fm.moveItem(at: previous, to: current)
        } else { try require(!tx.hadCurrent, "Interrupted installation is missing its prior copy; files preserved") }
        if fm.fileExists(atPath: stage.path) {
            try require((try String(contentsOf: stage.appendingPathComponent("owner.txt"), encoding: .utf8)) == tx.id, "Unowned staging folder; files preserved")
            try fm.removeItem(at: stage)
        }
        try fm.removeItem(at: journal)
    }
    func hit(_ point: String) throws { if failpoint == point { throw ForestError("Injected failure: " + point) } }
    func ensureGameStopped() throws {
        try require(NSRunningApplication.runningApplications(withBundleIdentifier: "com.CarrotsCrittersVulpineVisions.TheForestofLove").isEmpty,
                    "Quit The Forest of Love before changing its language.")
    }
    func validateBundleLinks(_ app: URL) throws {
        guard let entries = fm.enumerator(at: app, includingPropertiesForKeys: [.isSymbolicLinkKey], options: []) else { throw ForestError("Cannot inspect the game copy") }
        let prefix = app.resolvingSymlinksInPath().path + "/"
        for case let url as URL in entries {
            if try url.resourceValues(forKeys: [.isSymbolicLinkKey]).isSymbolicLink == true {
                try require(url.resolvingSymlinksInPath().path.hasPrefix(prefix), "An external symbolic link prevents safe signing: \(url.lastPathComponent). Files were preserved.")
            }
        }
    }
    func preparePayload(progress: (String) -> Void) throws -> (PayloadManifest, URL) {
        try check(resources.appendingPathComponent("forest-codec"), FilePin(bytes: (try Data(contentsOf: codec)).count, sha256: config.codecSha256))
        let packed = resources.appendingPathComponent("ForestLanguages.forestpack")
        try require(try fileSHA(packed) == config.payloadSha256, "The language package is damaged. Download the app again.")
        let cache = root.appendingPathComponent("Payload-" + config.payloadSha256)
        let manifestURL = cache.appendingPathComponent("manifest.json")
        if !fm.fileExists(atPath: cache.appendingPathComponent("verified.txt").path) {
            progress("Preparing all \(config.locales.filter { $0.code != "en" }.count) language packs…")
            if fm.fileExists(atPath: cache.path) { try fm.removeItem(at: cache) }
            try fm.createDirectory(at: cache, withIntermediateDirectories: true)
            let decoded = cache.appendingPathComponent("payload.zip")
            _ = try run(codec, ["inflate", packed.path, decoded.path])
            try require(try fileSHA(decoded) == config.decodedSha256, "Decoded language package failed its integrity check")
            _ = try run(URL(fileURLWithPath: "/usr/bin/ditto"), ["-x", "-k", decoded.path, cache.path])
            try fm.removeItem(at: decoded)
            try Data(config.decodedSha256.utf8).write(to: cache.appendingPathComponent("verified.txt"), options: .atomic)
        }
        try require(try fileSHA(manifestURL) == config.manifestSha256, "Cached language manifest is damaged. Preserve the game copy and reinstall the launcher.")
        let manifest = try JSONDecoder().decode(PayloadManifest.self, from: Data(contentsOf: manifestURL))
        let packedCodes = manifest.locales.map(\.code), configuredCodes = config.locales.map(\.code)
        try require(manifest.format == 1 && !packedCodes.isEmpty && Set(manifest.originals.map(\.path)).count == 14, "Unsupported language package")
        try require(Set(packedCodes).count == packedCodes.count && Set(configuredCodes).count == configuredCodes.count && configuredCodes.contains("en") && Set(packedCodes) == Set(configuredCodes).subtracting(["en"]), "Language catalog differs from package")
        return (manifest, cache)
    }
    func validateSource(_ source: URL, _ manifest: PayloadManifest) throws -> URL {
        let plist = try PropertyListSerialization.propertyList(from: Data(contentsOf: source.appendingPathComponent("Contents/Info.plist")), format: nil) as? [String: Any]
        try require(plist?["CFBundleIdentifier"] as? String == manifest.bundleID && plist?["CFBundleShortVersionString"] as? String == manifest.gameVersion, "Choose the original macOS version of The Forest of Love 0.45")
        try require(!source.resolvingSymlinksInPath().path.hasPrefix(root.resolvingSymlinksInPath().path + "/"), "Choose the original installed game, outside Forest Languages storage")
        let data = source.appendingPathComponent("Contents/Resources/Data")
        try require(try fileSHA(try safe(manifest.identityPath, beneath: data)) == manifest.identitySha256, "Unsupported game build")
        for file in manifest.originals {
            let path = try safe(file.path, beneath: data)
            if let hash = file.sha256 { try check(path, FilePin(bytes: file.bytes, sha256: hash)) }
            else { try require(!fm.fileExists(atPath: path.path), "The original installation contains a conflicting mod: \(file.path)") }
        }
        return data
    }
    func validateCurrent(_ manifest: PayloadManifest) throws {
        let value = try state(at: current), data = game.appendingPathComponent("Contents/Resources/Data")
        try require(Set(value.files.keys) == Set(manifest.originals.filter { value.locale != "en" || $0.sha256 != nil }.map(\.path)), "Installed ownership manifest differs")
        for original in manifest.originals {
            let path = try safe(original.path, beneath: data)
            if let pin = value.files[original.path] { try check(path, pin) }
            else { try require(!fm.fileExists(atPath: path.path), "A mod conflicts with English restore: \(original.path)") }
        }
    }
    func apply(source: URL, locale: String, sign: Bool = true, progress: (String) -> Void) throws -> URL {
        try locked {
            try ensureGameStopped()
            try recover()
            let (manifest, cache) = try preparePayload(progress: progress)
            let originalData = try validateSource(source, manifest)
            try require(locale == "en" || manifest.locales.contains(where: { $0.code == locale }), "Unknown language")
            let hasCurrent = fm.fileExists(atPath: current.path)
            if hasCurrent { try validateCurrent(manifest) }
            let capacity = try root.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage
            try require((capacity ?? 0) > 4_000_000_000, "At least 4 GB of free disk space is needed to prepare a game copy")
            let id = UUID().uuidString, stage = root.appendingPathComponent("Stage-" + id)
            let journal = root.appendingPathComponent("transaction.json"), previous = root.appendingPathComponent("Previous")
            let tx = Transaction(owner: Self.owner, id: id, stage: stage.lastPathComponent, hadCurrent: hasCurrent)
            try fm.createDirectory(at: stage, withIntermediateDirectories: false)
            try Data(id.utf8).write(to: stage.appendingPathComponent("owner.txt"))
            try write(tx, to: journal)
            do {
                progress("Preparing a separate game copy…")
                let stagedGame = stage.appendingPathComponent("The Forest of Love.app")
                let copySource = hasCurrent ? game : source
                do { _ = try run(URL(fileURLWithPath: "/bin/cp"), ["-cR", copySource.path, stagedGame.path]) }
                catch {
                    if fm.fileExists(atPath: stagedGame.path) { try fm.removeItem(at: stagedGame) }
                    try fm.copyItem(at: copySource, to: stagedGame)
                }
                try validateBundleLinks(stagedGame)
                let targetData = stagedGame.appendingPathComponent("Contents/Resources/Data")
                var installed: [String: FilePin] = [:]
                if locale == "en" {
                    for original in manifest.originals {
                        let target = try safe(original.path, beneath: targetData)
                        if fm.fileExists(atPath: target.path) { try fm.removeItem(at: target) }
                        if let hash = original.sha256 {
                            try fm.copyItem(at: try safe(original.path, beneath: originalData), to: target)
                            installed[original.path] = FilePin(bytes: original.bytes, sha256: hash)
                        }
                    }
                } else {
                    let selected = manifest.locales.first { $0.code == locale }!
                    var bases: [Data] = []
                    for base in manifest.baselines {
                        let url: URL
                        if base.path == "__bundle.asset" {
                            url = stage.appendingPathComponent("original.asset")
                            _ = try run(codec, ["extract", try safe(manifest.bundlePath, beneath: originalData).path, url.path])
                        } else { url = try safe(base.path, beneath: originalData) }
                        try check(url, FilePin(bytes: base.bytes, sha256: base.sha256)); bases.append(try Data(contentsOf: url, options: .mappedIfSafe))
                    }
                    for (index, file) in selected.files.enumerated() {
                        progress("Installing \(selected.name)… \(index + 1)/\(selected.files.count)")
                        var data = Data(); data.reserveCapacity(file.storageBytes)
                        for part in file.segments {
                            try require(part.bytes > 0 && part.bytes <= 65536 && part.offset >= 0, "Invalid resource segment")
                            if let blob = part.blob {
                                try require(blob.count == 64 && blob.allSatisfy { $0.isHexDigit }, "Invalid chunk identity")
                                let block = try Data(contentsOf: try safe("chunks/" + blob, beneath: cache))
                                try require(block.count == part.bytes && sha256(block) == blob, "Language chunk integrity failure")
                                data.append(block)
                            } else {
                                try require(part.base >= 0 && part.base < bases.count && part.offset <= bases[part.base].count - part.bytes, "Invalid source segment")
                                data.append(bases[part.base].subdata(in: part.offset..<(part.offset + part.bytes)))
                            }
                        }
                        try require(data.count == file.storageBytes && sha256(data) == file.storageSha256, "Reconstructed resource integrity failure: \(file.path)")
                        let target = try safe(file.path, beneath: targetData)
                        try fm.createDirectory(at: target.deletingLastPathComponent(), withIntermediateDirectories: true)
                        if file.bundle {
                            let asset = stage.appendingPathComponent("localized.asset"); try data.write(to: asset)
                            _ = try run(codec, ["compose", try safe(manifest.bundlePath, beneath: originalData).path, asset.path, target.path])
                            try fm.removeItem(at: asset)
                        } else { try data.write(to: target, options: .atomic) }
                        let pin = FilePin(bytes: file.bytes, sha256: file.sha256); try check(target, pin); installed[file.path] = pin
                    }
                    try fm.removeItem(at: stage.appendingPathComponent("original.asset"))
                }
                if sign {
                    progress("Signing and verifying the localized game copy…")
                    _ = try run(URL(fileURLWithPath: "/usr/bin/codesign"), ["--force", "--deep", "--sign", "-", stagedGame.path])
                    _ = try run(URL(fileURLWithPath: "/usr/bin/codesign"), ["--verify", "--deep", "--strict", stagedGame.path])
                }
                for (path, pin) in installed { try check(try safe(path, beneath: targetData), pin) }
                try write(InstalledState(owner: Self.owner, transaction: id, locale: locale, source: source.path, payloadSha256: config.payloadSha256, files: installed), to: stage.appendingPathComponent("state.json"))
                try ensureGameStopped()
                try hit("beforeSwap")
                if hasCurrent { try fm.moveItem(at: current, to: previous) }
                try hit("afterBackup")
                try fm.moveItem(at: stage, to: current)
                try hit("afterCommit")
                try recover()
                return game
            } catch {
                // Recover the committed or previous complete directory. Never
                // restore individual files over a partially installed game.
                try recover(); throw error
            }
        }
    }
    func verifyLaunch(expectedLocale: String) throws -> URL {
        try locked {
            try ensureGameStopped(); try recover()
            let (manifest, _) = try preparePayload(progress: { _ in })
            try validateCurrent(manifest)
            try require(try state(at: current).locale == expectedLocale, "The language changed in another launcher window. Apply your selected language again.")
            try validateBundleLinks(game)
            // Forest writes Contents/tfol.settings inside its app. That changes
            // an ad-hoc sealed entry during normal play. Re-seal only our owned
            // copy, after validating every installed localization resource.
            _ = try run(URL(fileURLWithPath: "/usr/bin/codesign"), ["--force", "--deep", "--sign", "-", game.path])
            _ = try run(URL(fileURLWithPath: "/usr/bin/codesign"), ["--verify", "--deep", "--strict", game.path])
            return game
        }
    }
}
