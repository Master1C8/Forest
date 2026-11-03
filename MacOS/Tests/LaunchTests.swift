import Foundation

@main
@MainActor struct LaunchTests {
    static var assertions = 0
    static func expect(_ condition: @autoclosure () throws -> Bool, _ message: String) throws {
        assertions += 1; if try !condition() { throw ForestError("TEST FAILED: " + message) }
    }
    static func rejected(_ reason: String, _ action: () throws -> Void) throws {
        do { try action() } catch {
            try expect(error.localizedDescription.contains(reason), "Unexpected rejection: " + error.localizedDescription); return
        }
        throw ForestError("Missing expected rejection: " + reason)
    }
    static func main() throws {
        let root = URL(fileURLWithPath: CommandLine.arguments[1]), fm = FileManager.default
        let app = root.appendingPathComponent("Owned copy ; touch INJECTED.app"), exe = app.appendingPathComponent("Contents/MacOS/The Forest of Love")
        let logs = root.appendingPathComponent("Logs with spaces")
        try fm.createDirectory(at: exe.deletingLastPathComponent(), withIntermediateDirectories: true)
        let info = app.appendingPathComponent("Contents/Info.plist")
        func plist(_ name: String?) throws {
            let values: [String: String] = name.map { ["CFBundleExecutable": $0] } ?? [:]
            try PropertyListSerialization.data(fromPropertyList: values, format: .xml, options: 0).write(to: info)
        }
        try plist("The Forest of Love")
        let script = "#!/bin/sh\nprintf 'owned-copy\\n%s\\n%s\\n' \"$PWD\" \"$#\"\nprintf 'stderr-captured\\n' >&2\nexit 0\n"
        try Data(script.utf8).write(to: exe); try fm.setAttributes([.posixPermissions: 0o755], ofItemAtPath: exe.path)
        let first = try GameLauncher.start(game: app, logs: logs)
        first.process.waitUntilExit()
        try expect(first.process.terminationStatus == 0, "native executable process exited successfully")
        try expect(first.process.executableURL?.path == exe.path, "exact owned executable, without open/Terminal/shell command")
        try expect(first.process.arguments == [], "no extra arguments")
        let output = try String(contentsOf: first.log, encoding: .utf8)
        try expect(output.contains("owned-copy\n" + exe.deletingLastPathComponent().path + "\n0\n"), "working directory and executable with spaces")
        try expect(output.contains("stderr-captured"), "stderr and stdout captured without pipes")
        try expect(!fm.fileExists(atPath: root.appendingPathComponent("INJECTED.app").path), "metacharacters stay literal")
        let second = try GameLauncher.start(game: app, logs: logs); second.process.waitUntilExit()
        try expect(second.log != first.log && fm.fileExists(atPath: first.log.path), "each run preserves its own log")
        try Data("#!/bin/sh\nexit 23\n".utf8).write(to: exe)
        let signal = DispatchSemaphore(value: 0), event = root.appendingPathComponent("exit-event.txt")
        let failed = try GameLauncher.start(game: app, logs: logs) { process, log in
            try? Data("\(process.terminationStatus)\n\(log.path)".utf8).write(to: event)
            signal.signal()
        }
        failed.process.waitUntilExit()
        try expect(failed.process.terminationStatus == 23, "startup failure remains observable")
        try expect(signal.wait(timeout: .now() + 2) == .success, "termination callback delivered")
        try expect(try String(contentsOf: event, encoding: .utf8) == "23\n" + failed.log.path, "termination callback carries exact exit status/log")
        try fm.setAttributes([.posixPermissions: 0o644], ofItemAtPath: exe.path)
        try rejected("cannot be executed") { _ = try GameLauncher.start(game: app, logs: logs) }
        try plist("../outside")
        try rejected("Invalid game executable name") { _ = try GameLauncher.start(game: app, logs: logs) }
        try plist(nil)
        try rejected("missing from Info.plist") { _ = try GameLauncher.start(game: app, logs: logs) }
        try plist("The Forest of Love"); try fm.removeItem(at: exe)
        let outside = root.appendingPathComponent("external-executable")
        try Data(script.utf8).write(to: outside); try fm.setAttributes([.posixPermissions: 0o755], ofItemAtPath: outside.path)
        try fm.createSymbolicLink(at: exe, withDestinationURL: outside)
        try rejected("leaves its owned app") { _ = try GameLauncher.start(game: app, logs: logs) }
        let result: [String: Any] = ["passed": true, "assertions": assertions, "gameLaunched": false,
            "boundary": "Real Process execution of disposable stub executables; replaces Unity/game startup only",
            "directExecutable": true, "pathsWithSpacesAndMetacharacters": true, "workingDirectory": "Contents/MacOS", "logs": "unique stdout/stderr file per run"]
        try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted, .sortedKeys]).write(to: root.appendingPathComponent("result.json"))
        print("PASS: \(assertions) direct-launch assertions; Unity never started")
    }
}
