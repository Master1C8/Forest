import Foundation

struct GameSession {
    let process: Process
    let log: URL
}

enum GameLauncher {
    // Execute the owned copy's native entry point directly. LaunchServices/open
    // is deliberately absent: Forest's macOS build needs executable launch.
    static func start(game: URL, logs: URL, onExit: (@Sendable (Process, URL) -> Void)? = nil) throws -> GameSession {
        let fm = FileManager.default
        let plist = try PropertyListSerialization.propertyList(from: Data(contentsOf: game.appendingPathComponent("Contents/Info.plist")), format: nil) as? [String: Any]
        guard let name = plist?["CFBundleExecutable"] as? String else { throw ForestError("The game executable is missing from Info.plist") }
        try require(!name.isEmpty && name != "." && name != ".." && !name.contains("/") && !name.contains("\\"), "Invalid game executable name")
        let directory = game.appendingPathComponent("Contents/MacOS", isDirectory: true)
        let executable = directory.appendingPathComponent(name)
        try require(executable.resolvingSymlinksInPath().path.hasPrefix(game.resolvingSymlinksInPath().path + "/"), "Game executable leaves its owned app")
        try require(fm.isExecutableFile(atPath: executable.path), "The game executable is missing or cannot be executed")
        try fm.createDirectory(at: logs, withIntermediateDirectories: true)
        let log = logs.appendingPathComponent("game-" + UUID().uuidString + ".log")
        try Data().write(to: log, options: .withoutOverwriting)
        let handle = try FileHandle(forWritingTo: log)
        defer { try? handle.close() }
        let process = Process()
        process.executableURL = executable
        process.currentDirectoryURL = directory
        process.arguments = []
        process.standardInput = FileHandle.nullDevice
        process.standardOutput = handle
        process.standardError = handle
        process.terminationHandler = { ended in onExit?(ended, log) }
        try process.run()
        return GameSession(process: process, log: log)
    }
}
