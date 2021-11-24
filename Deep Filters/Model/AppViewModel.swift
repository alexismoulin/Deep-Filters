import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedstyle: StyleEnum = .style1
    @Published var show: ShowImage = .noImage
    @Published var backgroundImage: UIImage?
    @Published var styledBackgroundImage: UIImage?

    func applyStyle(model: StyleModel) async {
        if let imageItem = backgroundImage {
            let optionalStyledImage = await model.performImageTransfer(
                image: imageItem,
                modelStyle: selectedstyle.rawValue
            )
            styledBackgroundImage = optionalStyledImage
        }
    }

}
