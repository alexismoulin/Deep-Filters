import Foundation

enum BackgroundPicker: Identifiable {
    // swiftlint:disable:next variable_name
    var id: Self { self }

    case camera, library, share
}
