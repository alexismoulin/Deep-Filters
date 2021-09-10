import SwiftUI

struct AnimatedRoundedButton: View {
    var title: String
    var systemImage: String
    var color: Color
    let action: () -> Void

    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                action()
            }
        } label: {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(color)
                VStack {
                    Image(systemName: systemImage)
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(title)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
