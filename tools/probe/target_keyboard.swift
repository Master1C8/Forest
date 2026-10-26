// Disposable QA input transport. Only process-targeted events; no global posting.
import AppKit
import CoreGraphics
import Foundation

enum Failure: Error { case guardFailed(String) }
func require(_ ok: Bool, _ message: String) throws {
    if !ok { throw Failure.guardFailed(message) }
}
func processRows() throws -> String {
    let p = Process(), pipe = Pipe()
    p.executableURL = URL(fileURLWithPath: "/bin/ps")
    p.arguments = ["-axo", "pid=,command="]; p.standardOutput = pipe
    try p.run()
    let data = pipe.fileHandleForReading.readDataToEndOfFile(); p.waitUntilExit()
    try require(p.terminationStatus == 0, "Process enumeration failed")
    return String(decoding: data, as: UTF8.self)
}
let args = CommandLine.arguments
do {
    try require((3...6).contains(args.count), "run-directory inspect|observe|left|down [milliseconds|expected-pid]; right|return milliseconds expected-pid expected-window; release-right|release-return expected-pid expected-window")
    let run = URL(fileURLWithPath: args[1]).standardizedFileURL.path
    let root = "/Users/antonkrutov/Desktop/Forest/localization/probes/"
    try require(run.hasPrefix(root) && !run.dropFirst(root.count).contains("/") &&
        run.dropFirst(root.count).hasPrefix("ru-20261026-"), "Only one isolated Forest QA candidate")
    let mode = args[2]
    try require(["inspect", "observe", "left", "down", "right", "return", "release-left", "release-down", "release-right", "release-return"].contains(mode), "Only passive observation, bounded arrows/Return or task-edge release supported")
    // New Bucky down pulses bind the same inspected PID/window as right/Return.
    // Retain the accepted doorway lane's four-argument down interface.
    let boundInput = ["right", "return", "release-right", "release-return"].contains(mode) ||
        (mode == "down" && args.count == 6) || (mode == "release-down" && args.count == 5)
    if boundInput {
        try require(args.count == (mode.hasPrefix("release-") ? 5 : 6), "Right/Return requires exact inspected PID/window")
    } else if mode == "inspect" {
        try require(args.count == 3, "Passive inspection has no action arguments")
    }
    let exe = run + "/game/The Forest of Love.exe"
    let variants = [exe, "Z:" + exe.replacingOccurrences(of: "/", with: "\\"),
        "Y:" + exe.replacingOccurrences(of: "/Users/antonkrutov", with: "").replacingOccurrences(of: "/", with: "\\")]
    let rows = try processRows().split(separator: "\n").filter { row in
        variants.contains { row.contains($0) } && !row.contains("/bin/zsh")
    }
    if mode != "observe" { try require(!rows.isEmpty, "No exact QA process") }
    // CrossOver's launcher and child both contain the game path. Bind input
    // to the one matching process that actually owns the native game window.
    let candidates = Dictionary(uniqueKeysWithValues: rows.map { row in
        (Int(row.trimmingCharacters(in: .whitespaces).split(separator: " ")[0])!, String(row))
    })
    let windows = (CGWindowListCopyWindowInfo(.optionAll, kCGNullWindowID) as? [[String: Any]] ?? []).filter {
        candidates[$0[kCGWindowOwnerPID as String] as? Int ?? -1] != nil &&
        ($0[kCGWindowLayer as String] as? Int) == 0 &&
        (($0[kCGWindowBounds as String] as? [String: Any])?["Width"] as? Double ?? 0) >= 1000 &&
        (($0[kCGWindowBounds as String] as? [String: Any])?["Height"] as? Double ?? 0) >= 700
    }
    if mode == "observe" {
        try require(args.count == 3, "Passive observation has no action arguments")
        let frontmost = NSWorkspace.shared.frontmostApplication?.processIdentifier ?? -1
        // Whitelist scalars only: no application/window names, full dictionaries,
        // process command lines, owner content or activation/input calls.
        var observation: [String: Any] = ["mode": mode,
            "unixTime": Date().timeIntervalSince1970, "frontmostPid": Int(frontmost),
            "candidateCount": candidates.count, "windowCount": windows.count,
            "status": windows.count == 1 ? "unique" : "unavailable-or-ambiguous"]
        if windows.count == 1 {
            observation["pid"] = windows[0][kCGWindowOwnerPID as String] as! Int
            observation["windowID"] = windows[0][kCGWindowNumber as String] as! Int
            observation["onScreen"] = windows[0][kCGWindowIsOnscreen as String] as? Bool ?? false
        }
        let data = try JSONSerialization.data(withJSONObject: observation, options: [.sortedKeys])
        print(String(decoding: data, as: UTF8.self))
        exit(0)
    }
    try require(windows.count == 1, "Matching QA processes must own exactly one game-sized window")
    let pid = pid_t(windows[0][kCGWindowOwnerPID as String] as! Int)
    let windowID = windows[0][kCGWindowNumber as String] as! Int
    if boundInput {
        let offset = mode.hasPrefix("release-") ? 3 : 4
        try require(Int(args[offset]) == Int(pid) && Int(args[offset+1]) == windowID,
            "Inspected task PID/window changed; no event sent")
    }
    let trusted = AXIsProcessTrusted()
    let foreground = NSWorkspace.shared.frontmostApplication?.processIdentifier ?? -1
    let details: [String: Any] = ["pid": Int(pid), "windowID": windowID,
        "candidateCount": candidates.count, "windowCount": windows.count, "accessibilityTrusted": trusted,
        "frontmostPid": Int(foreground), "mode": mode,
        "boundary": "CGEvent.postToPid only; no activation, global event, Win32 PostMessage, controller or axis writes"]
    let data = try JSONSerialization.data(withJSONObject: details, options: [.sortedKeys])
    print(String(decoding: data, as: UTF8.self)); fflush(stdout)
    if mode != "inspect" {
        try require(trusted, "Accessibility unavailable; no permission prompt or global fallback")
        let action = mode.replacingOccurrences(of: "release-", with: "")
        let keys: [String: CGKeyCode] = ["left": 123, "down": 125, "right": 124, "return": 36]
        let direction = action.prefix(1).uppercased() + action.dropFirst()
        let key = keys[action]!
        let source = CGEventSource(stateID: .privateState)!
        let up = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: false)!
        up.flags = []
        if mode.hasPrefix("release-") {
            // Caller must possess a task DOWN receipt; also bind recovery to
            // that exact native PID instead of accepting a replacement process.
            try require(boundInput || (args.count == 4 && Int(args[3]) == Int(pid)), "Task DOWN process identity required")
            up.postToPid(pid)
            print("post\(direction)Up pid=\(pid) window=\(windowID) unixTime=\(Date().timeIntervalSince1970)")
            exit(0)
        }
        try require(boundInput || args.count == 4, "Pulse duration required")
        let duration = Int(args[3]) ?? 0
        try require(duration >= 100 && duration <= 1000, "Pulse bound100–1000ms")
        try require(action != "return" || duration == 100, "Return is a single100ms task press")
        let down = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: true)!
        down.flags = []
        let previousInt = signal(SIGINT, SIG_IGN), previousTerm = signal(SIGTERM, SIG_IGN)
        defer { signal(SIGINT, previousInt); signal(SIGTERM, previousTerm) }
        // Fully construct both edges before sending. A synchronous bounded pulse
        // releases to the same verified process even on INT/TERM. The caller
        // must allow this at-most-one-second helper to finish, never SIGKILL it.
        down.postToPid(pid)
        print("post\(direction)Down pid=\(pid) window=\(windowID) unixTime=\(Date().timeIntervalSince1970)"); fflush(stdout)
        defer {
            up.postToPid(pid)
            print("post\(direction)Up pid=\(pid) window=\(windowID) unixTime=\(Date().timeIntervalSince1970)"); fflush(stdout)
        }
        Thread.sleep(forTimeInterval: Double(duration) / 1000.0)
    }
} catch {
    fputs("Target keyboard refused: \(error)\n", stderr); exit(1)
}
