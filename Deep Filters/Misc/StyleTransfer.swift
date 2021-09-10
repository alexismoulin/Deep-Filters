import SwiftUI
import CoreML

protocol StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage?
}

extension Style1: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model1 = try? Style1(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model1.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style2: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model2 = try? Style2(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model2.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style3: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model3 = try? Style3(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model3.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style4: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model4 = try? Style4(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model4.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style5: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model5 = try? Style5(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model5.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style6: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model6 = try? Style6(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model6.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style7: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model7 = try? Style7(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model7.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style8: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model8 = try? Style8(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model8.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style9: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model9 = try? Style9(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model9.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}

extension Style10: StyleTransfer {
    func performStyleTransfer(image: UIImage?) -> UIImage? {
        guard let img = image,
              let originalSize = image?.size,
              let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
              let buffer = resizedImage.toBuffer()
        else {
            return nil
        }

        guard let model10 = try? Style10(configuration: MLModelConfiguration()) else { return nil }
        let output = try? model10.prediction(image: buffer)
        if let unwrappedOutput = output {
            let stylizedBuffer = unwrappedOutput.stylizedImage
            return UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer)?.resizeTo(size: originalSize)
        } else {
            return nil
        }
    }
}
