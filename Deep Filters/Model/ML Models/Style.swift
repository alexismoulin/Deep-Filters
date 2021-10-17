import Foundation
import CoreML

enum Style: String, CaseIterable {

    case style1 = "Style1"
    case style2 = "Style2"
    case style3 = "Style3"
    case style4 = "Style4"
    case style5 = "Style5"
    case style6 = "Style6"
    case style7 = "Style7"
    case style8 = "Style8"
    case style9 = "Style9"
    case style10 = "Style10"

    func associatedImageName() -> String {
        switch self {
        case .style1:
            return "Starry Night"
        case .style2:
            return "June Tree"
        case .style3:
            return "Mosaic"
        case .style4:
            return "Pigeons"
        case .style5:
            return "Pixie"
        case .style6:
            return "Aquarium"
        case .style7:
            return "Ice"
        case .style8:
            return "Fractal"
        case .style9:
            return "Chromatic"
        case .style10:
            return "Rain Princess"
        }
    }

}
