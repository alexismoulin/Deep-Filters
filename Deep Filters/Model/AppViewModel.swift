import SwiftUI
import CoreML

class AppViewModel: ObservableObject {
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

    private func replaceWithStyle(optionalStyledImage: UIImage?) {
        items.removeAll()
        items.append(PhotoPickerModel(with: (optionalStyledImage ?? UIImage(named: "nothing")!)))
        styleApplied = true
    }

    func applyStyle() {
        switch selectedstyle {
        case .style1:
            let optionalStyledImage1 = ModelManager.model1?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage1)
        case .style2:
            let optionalStyledImage2 = ModelManager.model2?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage2)
        case .style3:
            let optionalStyledImage3 = ModelManager.model3?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage3)
        case .style4:
            let optionalStyledImage4 = ModelManager.model4?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage4)
        case .style5:
            let optionalStyledImage5 = ModelManager.model5?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage5)
        case .style6:
            let optionalStyledImage6 = ModelManager.model6?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage6)
        case .style7:
            let optionalStyledImage7 = ModelManager.model7?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage7)
        case .style8:
            let optionalStyledImage8 = ModelManager.model8?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage8)
        case .style9:
            let optionalStyledImage9 = ModelManager.model9?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage9)
        case .style10:
            let optionalStyledImage10 = ModelManager.model10?.performStyleTransfer(item: items.first)
            replaceWithStyle(optionalStyledImage: optionalStyledImage10)
        }
    }

    @discardableResult
    func share(excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> Bool {
        guard let source = UIApplication.shared.windows.last?.rootViewController else {
            return false
        }
        let viewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        viewController.excludedActivityTypes = excludedActivityTypes
        viewController.popoverPresentationController?.sourceView = source.view
        source.present(viewController, animated: true)
        return true
    }
}
