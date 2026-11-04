import Foundation
import Darwin

@main
@MainActor struct CoreTests {
    static var assertions = 0
    static func expect(_ condition: @autoclosure () throws -> Bool, _ text: String) throws {
        assertions += 1; if try !condition() { throw ForestError("TEST FAILED: " + text) }
    }
    static func rejected(_ reason: String, _ operation: () throws -> Void) throws {
        do { try operation() } catch {
            try expect(error.localizedDescription.contains(reason), "wrong rejection: " + error.localizedDescription); return
        }
        throw ForestError("TEST FAILED: expected rejection " + reason)
    }
    static func main() throws {
        let args = CommandLine.arguments
        let fm = FileManager.default
        let fixture = URL(fileURLWithPath: args[1]), resources = fixture.appendingPathComponent("Resources")
        let config = try JSONDecoder().decode(PackageConfig.self, from: Data(contentsOf: resources.appendingPathComponent("PackageConfig.json")))
        let source = URL(fileURLWithPath: args[2])
        let root = fixture.appendingPathComponent("Owned")
        let core = InstallerCore(root: root, resources: resources, config: config)
        let real = args.contains("--real")
        try expect(core.resolve(source) == source, "app detection")
        try expect(core.resolve(fixture.appendingPathComponent("Missing")) == nil, "missing app detection")
        let originalSettings = source.appendingPathComponent("Contents/tfol.settings")
        let settings = try Data(contentsOf: originalSettings)
        let originalAssembly = source.appendingPathComponent("Contents/Resources/Data/Managed/Assembly-CSharp.dll")
        let sourceHash = try fileSHA(originalAssembly)
        let sequence = real ? ["hi", "sw", "uk", "ru", "en"] : ["hi", "sw", "uk", "en", "en"]
        for code in sequence {
            var messages: [String] = []
            _ = try core.apply(source: source, locale: code, sign: real, progress: { messages.append($0); print($0) })
            if code == sequence[0] {
                let count = config.locales.filter { $0.code != "en" }.count
                try expect(messages.contains("Preparing all \(count) language packs…"), "progress reports actual package language count")
            }
            let state = try core.state(at: core.current)
            try expect(state.locale == code, "selected locale state")
            let (manifest, _) = try core.preparePayload(progress: { _ in })
            try core.validateCurrent(manifest)
            try core.validateLaunchVersion(manifest, expectedLocale: code)
            try expect(true, "installed selected language matches current payload")
            if code == sequence[0] {
                let stateURL = core.current.appendingPathComponent("state.json")
                let originalState = try Data(contentsOf: stateURL)
                let heading = core.game.appendingPathComponent("Contents/Resources/Data/sharedassets2.assets")
                let goodHeading = try Data(contentsOf: heading)
                var upgraded = false
                do {
                    defer { if !upgraded { try? goodHeading.write(to: heading); try? originalState.write(to: stateURL) } }
                    let olderPayload = String(repeating: "0", count: 64)
                    let unchanged = InstalledState(owner: state.owner, transaction: state.transaction, locale: state.locale,
                        source: state.source, payloadSha256: olderPayload, files: state.files)
                    try core.write(unchanged, to: stateURL)
                    try core.validateLaunchVersion(manifest, expectedLocale: code)
                    try expect(true, "other-language package updates retain matching selected resources")
                    let originalHeading = try Data(contentsOf: source.appendingPathComponent("Contents/Resources/Data/sharedassets2.assets"))
                    try originalHeading.write(to: heading)
                    var oldFiles = state.files
                    oldFiles["sharedassets2.assets"] = FilePin(bytes: originalHeading.count, sha256: sha256(originalHeading))
                    try core.write(InstalledState(owner: state.owner, transaction: state.transaction, locale: state.locale,
                        source: state.source, payloadSha256: olderPayload, files: oldFiles), to: stateURL)
                    try core.validateCurrent(manifest) // Ownership/hash integrity is valid; only the version differs.
                    try rejected("older language pack") { _ = try core.verifyLaunch(expectedLocale: code) }
                    _ = try core.apply(source: source, locale: code, sign: real, progress: { _ in })
                    upgraded = true
                }
                try core.validateCurrent(manifest)
                try core.validateLaunchVersion(manifest, expectedLocale: code)
                try expect(true, "older owned language version upgraded through normal apply")
            }
            _ = try core.validateSource(source, manifest)
            try expect(true, "all original resource hashes unchanged")
            for original in manifest.originals {
                let target = core.game.appendingPathComponent("Contents/Resources/Data/" + original.path)
                if code == "en", original.sha256 == nil { try expect(!fm.fileExists(atPath: target.path), "English removes only owned helpers") }
                else {
                    let pin = code == "en" ? FilePin(bytes: original.bytes, sha256: original.sha256!) : state.files[original.path]!
                    try core.check(target, pin); try expect(true, "resource readback")
                }
            }
            try expect(try Data(contentsOf: originalSettings) == settings, "original settings untouched")
            try expect(try fileSHA(originalAssembly) == sourceHash, "original assembly untouched")
            if code == sequence[0] {
                try Data("user preferences changed in managed copy".utf8).write(to: core.game.appendingPathComponent("Contents/tfol.settings"))
                try Data("personal save changed during play".utf8).write(to: core.game.appendingPathComponent("Contents/tfol.savegame"))
                try Data("unrelated mod".utf8).write(to: core.game.appendingPathComponent("Contents/Resources/unrelated-mod.txt"))
            } else {
                try expect(try String(contentsOf: core.game.appendingPathComponent("Contents/tfol.settings"), encoding: .utf8) == "user preferences changed in managed copy", "managed settings preserved across switches")
                try expect(try String(contentsOf: core.game.appendingPathComponent("Contents/tfol.savegame"), encoding: .utf8) == "personal save changed during play", "managed save preserved across switches")
                try expect(try String(contentsOf: core.game.appendingPathComponent("Contents/Resources/unrelated-mod.txt"), encoding: .utf8) == "unrelated mod", "unrelated mod preserved")
            }
            try expect(!fm.fileExists(atPath: root.appendingPathComponent("Previous").path), "transaction backup removed")
            try expect(!fm.fileExists(atPath: root.appendingPathComponent("transaction.json").path), "journal removed")
        }
        let labels = config.locales
        let duplicate = PackageConfig(payloadSha256: config.payloadSha256, decodedSha256: config.decodedSha256, codecSha256: config.codecSha256, manifestSha256: config.manifestSha256, locales: labels + [labels[0]])
        let duplicateCore = InstallerCore(root: root, resources: resources, config: duplicate)
        try rejected("Language catalog differs") { _ = try duplicateCore.preparePayload(progress: { _ in }) }
        let missing = PackageConfig(payloadSha256: config.payloadSha256, decodedSha256: config.decodedSha256, codecSha256: config.codecSha256, manifestSha256: config.manifestSha256, locales: Array(labels.dropLast()))
        let missingCore = InstallerCore(root: root, resources: resources, config: missing)
        try rejected("Language catalog differs") { _ = try missingCore.preparePayload(progress: { _ in }) }
        if real {
            try Data("settings changed during normal play".utf8).write(to: core.game.appendingPathComponent("Contents/tfol.settings"))
            _ = try core.verifyLaunch(expectedLocale: "en") // Validates signature and files; never opens a game.
            try expect(try String(contentsOf: core.game.appendingPathComponent("Contents/tfol.settings"), encoding: .utf8) == "settings changed during normal play", "re-signing preserves current settings")
        } else {
            for point in ["beforeSwap", "afterBackup", "afterCommit"] {
                let previous = try core.state(at: core.current).locale
                let broken = InstallerCore(root: root, resources: resources, config: config, failpoint: point)
                try rejected("Injected failure: " + point) { _ = try broken.apply(source: source, locale: "de", sign: false, progress: { _ in }) }
                let current = try core.state(at: core.current)
                try expect(current.locale == (point == "afterCommit" ? "de" : previous), "atomic directory recovery at " + point)
                let (manifest, _) = try core.preparePayload(progress: { _ in }); try core.validateCurrent(manifest)
                try expect(!fm.fileExists(atPath: root.appendingPathComponent("transaction.json").path), "recovery finalized")
            }
            try core.locked {
                let another = InstallerCore(root: root, resources: resources, config: config)
                try rejected("Another Forest installer") { try another.locked {} }
            }
            try rejected("Unsafe resource path") { _ = try core.safe("../outside", beneath: root) }
            let link = root.appendingPathComponent("link")
            try fm.createSymbolicLink(at: link, withDestinationURL: fixture)
            try rejected("Resource escapes") { _ = try core.safe("link/file", beneath: root) }
            let ownedAssembly = core.game.appendingPathComponent("Contents/Resources/Data/Managed/Assembly-CSharp.dll")
            let goodAssembly = try Data(contentsOf: ownedAssembly)
            try Data("foreign mod".utf8).write(to: ownedAssembly)
            try rejected("Resource differs") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try expect(try String(contentsOf: ownedAssembly, encoding: .utf8) == "foreign mod", "foreign mod not overwritten")
            try goodAssembly.write(to: ownedAssembly)
            let identity = source.appendingPathComponent("Contents/Resources/Data/globalgamemanagers.assets")
            let goodIdentity = try Data(contentsOf: identity)
            try Data("different build".utf8).write(to: identity)
            try rejected("Unsupported game build") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try goodIdentity.write(to: identity)
            let helper = source.appendingPathComponent("Contents/Resources/Data/Managed/VNRevivalQuestLayout.dll")
            try Data("foreign helper".utf8).write(to: helper)
            try rejected("conflicting mod") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try fm.removeItem(at: helper)
            let cacheManifest = root.appendingPathComponent("Payload-" + config.payloadSha256 + "/manifest.json")
            let goodManifest = try Data(contentsOf: cacheManifest)
            try Data("{}".utf8).write(to: cacheManifest)
            try rejected("Cached language manifest") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try goodManifest.write(to: cacheManifest)
            let stateURL = core.current.appendingPathComponent("state.json"), goodState = try Data(contentsOf: stateURL)
            var value = try JSONSerialization.jsonObject(with: goodState) as! [String: Any]; value["owner"] = "someone else"
            try JSONSerialization.data(withJSONObject: value).write(to: stateURL)
            try rejected("not owned") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try expect(fm.fileExists(atPath: core.game.path), "unowned game preserved")
            try goodState.write(to: stateURL)
            let previous = root.appendingPathComponent("Previous")
            try fm.createDirectory(at: previous, withIntermediateDirectories: false)
            try rejected("Unclaimed Previous") { try core.locked { try core.recover() } }
            try fm.removeItem(at: previous)
            let externalLink = core.game.appendingPathComponent("Contents/external-link")
            try fm.createSymbolicLink(at: externalLink, withDestinationURL: fixture)
            try rejected("external symbolic link") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try expect(fm.fileExists(atPath: fixture.path), "external signing target preserved")
            try fm.removeItem(at: externalLink)
            let packed = resources.appendingPathComponent("ForestLanguages.forestpack"), goodPacked = try Data(contentsOf: packed)
            try Data("damaged".utf8).write(to: packed)
            try rejected("language package is damaged") { _ = try core.apply(source: source, locale: "ja", sign: false, progress: { _ in }) }
            try goodPacked.write(to: packed)
            try rejected("language changed in another") { _ = try core.verifyLaunch(expectedLocale: "ja") }
        }
        let result: [String: Any] = ["passed": true, "assertions": assertions, "realResources": real,
            "gameLaunched": false, "originalGameModified": false, "testedSequence": sequence,
            "boundary": real ? "Native macOS resources, isolated signed game copies, exact hash readback; no game startup" : "Synthetic resources, real filesystem/codec/locking/transaction/cache; signing replaced by sign=false"]
        try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted, .sortedKeys]).write(to: fixture.appendingPathComponent("result.json"))
        print("PASS: \(assertions) assertions; realResources=\(real)")
    }
}
