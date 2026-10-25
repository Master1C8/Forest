import Foundation
import Vision
import AppKit

// Local Apple Vision discovery aid; no network or translation service.
let args = CommandLine.arguments
guard args.count == 2 else { fatalError("Usage: ocr_textures manifest.json") }
let manifest = URL(fileURLWithPath: args[1])
let rows = try JSONSerialization.jsonObject(with: Data(contentsOf: manifest)) as! [[String: Any]]
let root = manifest.deletingLastPathComponent()
for row in rows where row["status"] as? String == "exported" {
    autoreleasepool {
        var output: [String: Any] = ["id": row["id"]!, "path": row["path"]!]
        do {
            let url = root.appendingPathComponent(row["path"] as! String)
            let request = VNRecognizeTextRequest()
            request.usesCPUOnly = true
            request.recognitionLevel = .fast
            request.revision = VNRecognizeTextRequestRevision1
            request.usesLanguageCorrection = false
            request.recognitionLanguages = ["en-US"]
            request.minimumTextHeight = 0.005
            let handler = VNImageRequestHandler(url: url)
            try handler.perform([request])
            output["observations"] = (request.results ?? []).compactMap { observation -> [String: Any]? in
                guard let c = observation.topCandidates(1).first else { return nil }
                let b = observation.boundingBox
                return ["text": c.string, "confidence": c.confidence,
                        "bbox": [b.origin.x,b.origin.y,b.width,b.height]]
            }
        } catch { output["error"] = String(describing: error) }
        let data = try! JSONSerialization.data(withJSONObject: output, options: [.sortedKeys])
        print(String(data: data, encoding: .utf8)!)
        fflush(stdout)
    }
}
