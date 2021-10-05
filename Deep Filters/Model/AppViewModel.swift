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

    func applyStyle(model: StyleTransfer) {
        let optionalStyledImage = model.performStyleTransfer(item: items.first)
        replaceWithStyle(optionalStyledImage: optionalStyledImage)
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
