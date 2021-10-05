import Foundation
import CoreML

enum Style: String, CaseIterable {

    case style1 = "Starry Night"
    case style2 = "June Tree"
    case style3 = "Mosaic"
    case style4 = "Pigeons"
    case style5 = "Pixie"
    case style6 = "Aquarium"
    case style7 = "Ice"
    case style8 = "Fractal"
    case style9 = "Chromatic"
    case style10 = "Rain Princess"

    enum ModelManager {
        static let model1 = try? Style1(configuration: MLModelConfiguration())
        static let model2 = try? Style2(configuration: MLModelConfiguration())
        static let model3 = try? Style3(configuration: MLModelConfiguration())
        static let model4 = try? Style4(configuration: MLModelConfiguration())
        static let model5 = try? Style5(configuration: MLModelConfiguration())
        static let model6 = try? Style6(configuration: MLModelConfiguration())
        static let model7 = try? Style7(configuration: MLModelConfiguration())
        static let model8 = try? Style8(configuration: MLModelConfiguration())
        static let model9 = try? Style9(configuration: MLModelConfiguration())
        static let model10 = try? Style10(configuration: MLModelConfiguration())
    }

    func associateModel() -> StyleTransfer {
        switch self {
        case .style1:
            return ModelManager.model1!
        case .style2:
            return ModelManager.model2!
        case .style3:
            return ModelManager.model3!
        case .style4:
            return ModelManager.model4!
        case .style5:
            return ModelManager.model5!
        case .style6:
            return ModelManager.model6!
        case .style7:
            return ModelManager.model7!
        case .style8:
            return ModelManager.model8!
        case .style9:
            return ModelManager.model9!
        case .style10:
            return ModelManager.model10!
        }
    }
}
