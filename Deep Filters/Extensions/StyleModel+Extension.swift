import CoreML
import AVFoundation
import UIKit

// extension for images
extension StyleModel {

    func performImageTransfer(image: UIImage?, modelStyle: String) -> UIImage? {

        guard let originalSize = image?.size else { return nil }
        guard let buffer = convertToPixelBuffer(image: image) else { return nil }
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

// extension for videos
extension StyleModel {

    private func extractAllFramesToOutput(videoURL: URL) async -> [StyleInput]? {
        var bufferArray: [StyleInput] = []
        print(videoURL)
        let asset = AVAsset(url: videoURL)
        guard let reader = try? AVAssetReader(asset: asset) else { return nil }
        let videoTrack = asset.tracks(withMediaType: .video).first!
        let outputSettings = [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32ARGB)]
        let trackReaderOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: outputSettings)
        reader.add(trackReaderOutput)
        reader.startReading()

        while let sampleBuffer = trackReaderOutput.copyNextSampleBuffer() {
            if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)?.resizeBuffer() {
                bufferArray.append(StyleInput(image: imageBuffer))
            }
        }
        return bufferArray
    }

    private func performVideoTransfer(videoURL: URL?, modelStyle: String) async -> [UIImage] {
        var resultArray: [UIImage] = []
        guard let url = videoURL else { return [] }
        guard let framesArray = await extractAllFramesToOutput(videoURL: url) else { return [] }
        let model = StyleModel(modelStyle: modelStyle)
        guard let outputs = try? model.predictions(inputs: framesArray) else { return [] }
        for output in outputs {
            let stylizedBuffer = output.stylizedImage
            if let outputImage = UIImage.imageFromCVPixelBuffer(pixelBuffer: stylizedBuffer) {
                resultArray.append(outputImage)
            }
        }
        return resultArray
    }

    func renderVideo(videoURL: URL?, modelStyle: String) async -> URL {
        let settings = RenderSettings()
        let imageArray: [UIImage] = await performVideoTransfer(videoURL: videoURL, modelStyle: modelStyle)
        let imageAnimator = ImageAnimator(renderSettings: settings, imageArray: imageArray)
        let videoURL = await imageAnimator.render()
        return videoURL
    }

}
