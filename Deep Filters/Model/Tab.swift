import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems: [TabItem] = [
    TabItem(text: "Styles", icon: "photo.on.rectangle.angled", tab: .style, color: .teal),
    TabItem(text: "Filters", icon: "camera.filters", tab: .filter, color: .pink)
]

enum Tab: String {
    case style, filter
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }

}
