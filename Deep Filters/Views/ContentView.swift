import SwiftUI

struct ContentView: View {

    @State private var backgroundPicker: BackgroundPicker?
    @StateObject var appViewModel = AppViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let testMode: Bool = false

    // MARK: - Buttons

    var applyFilterButton: some View {
        AnimatedRoundedButton(title: "Apply", systemImage: "play", color: .green) {
            await appViewModel.applyStyle(model: StyleModel(modelStyle: appViewModel.selectedstyle.rawValue))
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
            PhotoLibrary { image in
                appViewModel.backgroundImage = image
                backgroundPicker = nil
                appViewModel.styleApplied = false
            }
        }
        if pickerType == .share {
            ShareSheet(image: appViewModel.backgroundImage!)
        }
    }

    // MARK: - Sections

    var pictureSection: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                BackgroundEffect(color1: .primary, color2: .secondary)
                // Image
                if appViewModel.backgroundImage != nil {
                    Image(uiImage: appViewModel.backgroundImage!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Text("First, select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                // Buttons
                if appViewModel.backgroundImage == nil {
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
            Divider()
            BannerAd()
            Divider()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(StyleEnum.allCases, id: \.self) { style in
                        ZStack(alignment: .bottom) {
                            Image(StyleEnum.getAssociatedImageName(style: style))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(StyleEnum.getAssociatedImageName(style: style))
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
        if appViewModel.backgroundImage != nil {
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
