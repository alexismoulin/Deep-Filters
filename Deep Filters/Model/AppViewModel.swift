import SwiftUI
import CoreML

class AppViewModel: ObservableObject {
    @Published var selectedstyle: Style = .style1
    @Published var styleApplied: Bool = false
    @Published var items: [MediaPickerModel] = []

    func append(item: MediaPickerModel) {
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
        items.append(MediaPickerModel(with: (optionalStyledImage ?? UIImage(named: "nothing")!)))
        styleApplied = true
    }

    func applyStyle(model: StyleTransfer) {
        if let movieItem = items.first?.url {
            let optionalStyledImage = model.performStyleTransfer(videoURL: movieItem)
            replaceWithStyle(optionalStyledImage: optionalStyledImage)
        }
        if let imageItem = items.first?.photo {
            let optionalStyledImage = model.performStyleTransfer(image: imageItem)
            replaceWithStyle(optionalStyledImage: optionalStyledImage)
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
