import SwiftUI
import CoreML

class AppViewModel: ObservableObject {
    @Published var backgroundImage: UIImage?
    @Published var selectedstyle: Style = .style1
    @Published var styleApplied: Bool = false
    @Published var items: [PhotoPickerModel] = []

    func append(item: PhotoPickerModel) {
        items.append(item)
    }

    func deleteAll() {
        for index in items.indices {
            items[index].delete()
        }

        items.removeAll()
    }

    func applyStyle() {
        switch selectedstyle {
        case .style1:
            let optionalStyledImage1 = ModelManager.model1?.performStyleTransfer(item: items.first)
            backgroundImage = optionalStyledImage1
            items.removeAll()
            items.append(PhotoPickerModel(with: backgroundImage!))
            styleApplied = true
        case .style2:
            let optionalStyledImage2 = ModelManager.model2?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage2
            styleApplied = true
        case .style3:
            let optionalStyledImage3 = ModelManager.model3?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage3
            styleApplied = true
        case .style4:
            let optionalStyledImage4 = ModelManager.model4?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage4
            styleApplied = true
        case .style5:
            let optionalStyledImage5 = ModelManager.model5?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage5
            styleApplied = true
        case .style6:
            let optionalStyledImage6 = ModelManager.model6?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage6
            styleApplied = true
        case .style7:
            let optionalStyledImage7 = ModelManager.model7?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage7
            styleApplied = true
        case .style8:
            let optionalStyledImage8 = ModelManager.model8?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage8
            styleApplied = true
        case .style9:
            let optionalStyledImage9 = ModelManager.model9?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage9
            styleApplied = true
        case .style10:
            let optionalStyledImage10 = ModelManager.model10?.performStyleTransfer(image: backgroundImage)
            backgroundImage = optionalStyledImage10
            styleApplied = true
        }
    }

    @discardableResult
    func share(excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> Bool {
        guard let source = UIApplication.shared.windows.last?.rootViewController else {
            return false
        }
        let viewController = UIActivityViewController(activityItems: [backgroundImage!], applicationActivities: nil)
        viewController.excludedActivityTypes = excludedActivityTypes
        viewController.popoverPresentationController?.sourceView = source.view
        source.present(viewController, animated: true)
        return true
    }
}
