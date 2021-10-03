import SwiftUI
import VisualEffects

struct ContentView: View {

    @State private var backgroundPicker: BackgroundPicker?
    @StateObject var appViewModel = AppViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let testMode: Bool = false

    // MARK: - Buttons

    var applyFilterButton: some View {
        AnimatedRoundedButton(title: "Apply", systemImage: "play", color: .green) {
            appViewModel.applyStyle()
        }
    }

    var shareButton: some View {
        AnimatedRoundedButton(title: "Share", systemImage: "square.and.arrow.up", color: .purple) {
            backgroundPicker = .share
        }
    }

    var cancelButton: some View {
        AnimatedRoundedButton(title: "Cancel", systemImage: "xmark", color: .red) {
            appViewModel.styleApplied = false
            appViewModel.backgroundImage = nil
            appViewModel.deleteAll()
        }
    }

    var cameraButton: some View {
        AnimatedActionButton(title: "Camera", systemImage: "camera.fill") {
            backgroundPicker = .camera
        }
    }

    var libraryButton: some View {
        AnimatedActionButton(title: "Library", systemImage: "photo.fill") {
            backgroundPicker = .library
        }
    }

    // MARK: - Sheet builder

    @ViewBuilder
    func presentSheet(pickerType: BackgroundPicker) -> some View {
        if pickerType == .camera {
            Camera { image in
                appViewModel.backgroundImage = image
                backgroundPicker = nil
                appViewModel.styleApplied = false
            }
        }
        if pickerType == .library {
            PhotoPicker(appViewModel: appViewModel) { _ in
                backgroundPicker = nil
                appViewModel.styleApplied = false
            }
        }
        if pickerType == .share {
            if let unwrappedImage = appViewModel.backgroundImage {
                ShareSheet(image: (unwrappedImage))
            } else {
                Text("No image !")
            }
        }
    }

    // MARK: - Sections

    var pictureSection: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                BackgroundEffectView(color1: .primary, color2: .secondary)
                // Image
                if !appViewModel.items.isEmpty {
                    ItemsView(appViewModel: appViewModel)
                } else {
                    Text("First, select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                // Buttons
                if appViewModel.items.isEmpty {
                    HStack {
                        if Camera.isAvailable || testMode {
                            cameraButton.padding(horizontalSizeClass == .compact ? 20: 50)
                        }
                        Spacer()
                        if PhotoLibrary.isAvailable || testMode {
                            libraryButton.padding(horizontalSizeClass == .compact ? 20: 50)
                        }
                    }.position(x: geo.size.width / 2, y: 100.0)
                }
            }
        }
    }

    var chooseStyleSection: some View {
        VStack(alignment: .leading) {
            Text("Choose a style")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Style.allCases, id: \.self) { style in
                        ZStack(alignment: .bottom) {
                            Image(style.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(style.rawValue)
                                .font(.subheadline)
                                .fontWeight(style == appViewModel.selectedstyle ? .bold : .none)
                                .padding(2)
                                .frame(maxWidth: .infinity)
                                .background(Color.black.opacity(0.6))
                                .foregroundColor(.white)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            withAnimation {
                                appViewModel.selectedstyle = style
                            }
                        }
                        .shadow(radius: style == appViewModel.selectedstyle ? 3 : 0)
                        .padding(5)
                        .scaleEffect(style == appViewModel.selectedstyle ? 1.1 : 1)
                        .padding(.bottom, 5)
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func createActionButtonSection() -> some View {
        if !appViewModel.items.isEmpty {
            if appViewModel.styleApplied {
                HStack(spacing: 20) {
                    cancelButton
                    shareButton
                }
            } else {
                HStack(spacing: 20) {
                    cancelButton
                    applyFilterButton
                }
            }
        }
    }

    // MARK: - body

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    pictureSection.ignoresSafeArea()
                    createActionButtonSection().offset(x: -20, y: 30)
                }
                chooseStyleSection
            }
        }
        .sheet(item: $backgroundPicker) { pickerType in
            presentSheet(pickerType: pickerType)
        }

    }

}
