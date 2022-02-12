import SwiftUI

struct AnimatedRoundedButton: View {
    var title: String
    var systemImage: String
    var color: Color
    let action: () async -> Void

    var body: some View {
        Button {
            Task {
                await action()
            }
        } label: {
            ZStack {
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial) {
                    ZStack {
                        color
                            .cornerRadius(24)
                            .opacity(0.8)
                            .blur(radius: 3)
                    }
                }
            }
            .cornerRadius(24)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(.gray, lineWidth: 5)
                        .blendMode(.overlay)

                    VStack {
                        Image(systemName: systemImage)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        Text(title)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                    }

                }
            )
            .frame(width: 60, height: 60, alignment: .center)
        }.buttonStyle(.plain)
    }
}

struct AnimatedRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedRoundedButton(title: "Apply", systemImage: "play", color: .green) { }
    }
}
