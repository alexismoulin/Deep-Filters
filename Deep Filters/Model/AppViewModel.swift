import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedstyle: StyleEnum = .style1
    @Published var styleApplied: Bool = false
    @Published var backgroundImage: UIImage?

    func applyStyle(model: StyleModel) async {
        if let imageItem = backgroundImage {
            let optionalStyledImage = model.performImageTransfer(image: imageItem, modelStyle: selectedstyle.rawValue)
            backgroundImage = optionalStyledImage
            styleApplied = true
        }
    }

}
