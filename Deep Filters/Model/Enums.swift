import Foundation

enum BackgroundPicker: Identifiable {
    var id: Self { self }

    case camera, library, share
}

enum ShowImage {
    case noImage, regular, styled
}
