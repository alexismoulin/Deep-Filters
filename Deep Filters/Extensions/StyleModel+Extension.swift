import CoreML
import AVFoundation
import UIKit

extension StyleModel {

    private func extractAllFramesToOutput(videoURL: URL) -> [StyleInput]? {
        var bufferArray: [StyleInput] = []
        print(videoURL)
        let asset = AVAsset(url: videoURL)
        guard let reader = try? AVAssetReader(asset: asset) else { return nil }
        let videoTrack = asset.tracks(withMediaType: .video).first!
        let outputSettings = [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)]
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

    private func performVideoTransfer(videoURL: URL?, modelStyle: String) -> [UIImage] {
        var resultArray: [UIImage] = []
        guard let url = videoURL else { return [] }
        guard let framesArray = extractAllFramesToOutput(videoURL: url) else { return [] }
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

    func renderVideo(videoURL: URL?, modelStyle: String, completion: @escaping (URL) -> Void) {
        let settings = RenderSettings()
        let imageArray: [UIImage] = performVideoTransfer(videoURL: videoURL, modelStyle: modelStyle)
        let imageAnimator = ImageAnimator(renderSettings: settings, imageArray: imageArray)
        imageAnimator.render {
            print("yes -> \(settings.outputURL)")
            completion(settings.outputURL)
        }
    }

}
