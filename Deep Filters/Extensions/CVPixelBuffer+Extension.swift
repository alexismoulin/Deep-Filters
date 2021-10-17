import AVFoundation
import UIKit

extension CVPixelBuffer {
    func resizeBuffer() -> CVPixelBuffer? {
        return UIImage.imageFromCVPixelBuffer(pixelBuffer: self)?.resizeTo(size: CGSize(width: 512, height: 512))?.toBuffer()
    }
}
