import CoreML
import AVFoundation
import UIKit
import Photos

// extension for images
extension StyleModel {

    func performImageTransfer(image: UIImage?, modelStyle: String) -> UIImage? {

        guard let originalSize = image?.size else { return nil }
        guard let buffer = image?.convertToPixelBuffer() else { return nil }
        let model = StyleModel(modelStyle: modelStyle)

        let output = try? model.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}
