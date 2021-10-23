import AVFoundation
import UIKit

extension CVPixelBuffer {
    func resizeBuffer() -> CVPixelBuffer? {
        return UIImage
            .imageFromCVPixelBuffer(pixelBuffer: self)?
            .resizeTo(size: CGSize(width: MatrixSize.width, height: MatrixSize.height))?
            .toBuffer()
    }
}
