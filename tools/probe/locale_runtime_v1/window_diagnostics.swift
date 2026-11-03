import Foundation
import CoreGraphics
let rows = CGWindowListCopyWindowInfo([.optionAll, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]] ?? []
let selected = rows.filter { row in
    let name = (row[kCGWindowName as String] as? String ?? "")
    let owner = (row[kCGWindowOwnerName as String] as? String ?? "")
    return name.contains("Forest") || owner.contains("wine") || owner.contains("Forest")
}
let screens: [[String: Any]] = [["mainDisplay": CGMainDisplayID(), "physicalWidth": CGDisplayPixelsWide(CGMainDisplayID()), "physicalHeight": CGDisplayPixelsHigh(CGMainDisplayID())]]
let data = try JSONSerialization.data(withJSONObject: ["windows": selected, "screens": screens], options: [.prettyPrinted, .sortedKeys])
FileHandle.standardOutput.write(data)
