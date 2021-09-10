import SwiftUI

struct AnimatedActionButton: View {
    var title: String
    var systemImage: String
    let action: () -> Void

    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                action()
            }
        } label: {
            HStack {
                Image(systemName: systemImage)
                Text(title)
            }
        }.buttonStyle(GradientButtonStyle())
    }
}
