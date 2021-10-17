import AVFoundation
import CoreMedia
import UIKit

func convertToPixelBuffer(image: UIImage?) -> CVPixelBuffer? {
    guard let img = image,
          let resizedImage = img.resizeTo(size: CGSize(width: 512, height: 512)),
          let buffer = resizedImage.toBuffer()
    else {
        return nil
    }
    return buffer
}

func extractFirstFrame(videoURL: URL) -> UIImage? {
    print(videoURL)
    let asset = AVAsset(url: videoURL)
    let generator = AVAssetImageGenerator.init(asset: asset)
    let cgImage = try? generator.copyCGImage(at: CMTime(value: 0, timescale: 1), actualTime: nil)
    if let img = cgImage {
        return UIImage(cgImage: img)
    } else {
        return nil
    }
}

func extractAllFrames(videoURL: URL) -> [CVPixelBuffer]? {
    var bufferArray: [CVPixelBuffer] = []
    print(videoURL)
    let asset = AVAsset(url: videoURL)
    guard let reader = try? AVAssetReader(asset: asset) else { return nil }
    let videoTrack = asset.tracks(withMediaType: .video).first!
    let outputSettings = [String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)]
    let trackReaderOutput = AVAssetReaderTrackOutput(track: videoTrack, outputSettings: outputSettings)
    reader.add(trackReaderOutput)
    reader.startReading()

    while let sampleBuffer = trackReaderOutput.copyNextSampleBuffer() {
        if let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            bufferArray.append(imageBuffer)
        }
    }

    return bufferArray
}
