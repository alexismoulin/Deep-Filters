import SwiftUI

struct ContentView: View {

    @State private var backgroundPicker: BackgroundPicker?
    @StateObject var appViewModel = AppViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let testMode: Bool = false

    var textStyle: String {
        StyleEnum.getAssociatedImageName(style: appViewModel.selectedstyle)
    }

    // MARK: - Buttons

    var applyFilterButton: some View {
        AnimatedRoundedButton(title: "Apply", systemImage: "play", color: .green) {
            await appViewModel.applyStyle(model: StyleModel(modelStyle: appViewModel.selectedstyle.rawValue))
            appViewModel.show = .styled
        }
    }

    var shareButton: some View {
        AnimatedRoundedButton(title: "Share", systemImage: "square.and.arrow.up", color: .purple) {
            backgroundPicker = .share
        }
    }

    var cancelButton: some View {
        AnimatedRoundedButton(title: "Cancel", systemImage: "xmark", color: .red) {
            if appViewModel.show == .styled {
                appViewModel.show = .regular
                appViewModel.styledBackgroundImage = nil
            } else if appViewModel.show == .regular {
                appViewModel.show = .noImage
                appViewModel.backgroundImage = nil
            }
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
                appViewModel.show = .regular
            }
        }
        if pickerType == .library {
            PhotoLibrary { image in
                appViewModel.backgroundImage = image
                backgroundPicker = nil
                appViewModel.show = .regular
            }
        }
        if pickerType == .share {
            ShareSheet(image: appViewModel.styledBackgroundImage!)
        }
    }

    // MARK: - Sections

    var pictureSection: some View {
        ZStack {
            // Background
            BackgroundEffect(color1: .primary, color2: .secondary)
                .ignoresSafeArea()
            // Image
            if appViewModel.show == .noImage {
                Text("First, select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
            } else if appViewModel.show == .regular {
                Image(uiImage: appViewModel.backgroundImage!)
                    .resizable()
                    .scaledToFit()
            } else if appViewModel.show == .styled {
                Image(uiImage: appViewModel.styledBackgroundImage!)
                    .resizable()
                    .scaledToFit()
            }
            // Buttons
            if appViewModel.show == .noImage {
                HStack {
                    if Camera.isAvailable || testMode {
                        cameraButton.padding(horizontalSizeClass == .compact ? 20: 50)
                    }
                    Spacer()
                    if PhotoLibrary.isAvailable || testMode {
                        libraryButton.padding(horizontalSizeClass == .compact ? 20: 50)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }

    func styleCard(style: StyleEnum) -> some View {
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

    var chooseStyleSection: some View {
        VStack(alignment: .leading) {
            Text("Choose a style: ")
                .font(.headline)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(StyleEnum.allCases, id: \.self) { style in
                        styleCard(style: style)
                    }
                }
            }
        }
        .frame(height: 160)
        .padding(.horizontal)
        .background(Color("Background"))
    }

    @ViewBuilder
    func createActionButtonSection() -> some View {
        if appViewModel.backgroundImage != nil {
            if appViewModel.show == .styled {
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
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    pictureSection
                    Divider()
                    chooseStyleSection
                }
                createActionButtonSection()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .offset(x: -24, y: -130)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(textStyle)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                        Text(textStyle)
                            .font(.headline.bold())
                    }.frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Style: \(textStyle)")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: setNavigationBar)
            .sheet(item: $backgroundPicker) { pickerType in
                presentSheet(pickerType: pickerType)
            }
        }
    }

    func setNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }

}
