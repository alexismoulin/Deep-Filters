import Foundation
import CoreML

enum StyleEnum: String, CaseIterable {
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
    case style11 = "Style11"
    case style12 = "Style12"
    case style13 = "Style13"
    case style14 = "Style14"
    case style15 = "Style15"

    static func getAssociatedImageName(style: StyleEnum) -> String {
        let dict: [StyleEnum: String] = [
            .style1: "Starry Night", .style2: "June Tree", .style3: "Mosaic",
            .style4: "Pigeons", .style5: "Pixie", .style6: "Aquarium",
            .style7: "Ice", .style8: "Fractal", .style9: "Chromatic",
            .style10: "Rain Princess", .style11: "Majestic", .style12: "Tron",
            .style13: "Simpsons", .style14: "Street Art", .style15: "Night Garden"
        ]
        return dict[style, default: "image-missing"]
    }
}
