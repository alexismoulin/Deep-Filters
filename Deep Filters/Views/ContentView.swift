import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var appViewModel = AppViewModel()

    @State private var backgroundPicker: BackgroundPicker?

    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker: Bool = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet: Bool = false
    @State private var selectedTab: Tab = .style

    let context = CIContext()
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

    var chooseFilterSection: some View {
        VStack(spacing: 30) {
            HStack {
                Text("Intensity")
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity) { _ in
                        applyProcessing()
                    }
            }
            Button {
                showingFilterSheet = true
            } label: {
                AngularButton(title: "Choose a filter", icon: "")
            }
        }
        .frame(height: 160)
        .padding(.horizontal)
        .background(Color("Background"))
    }

    @ViewBuilder
    func chooseSection() -> some View {
        if selectedTab == .style {
            chooseStyleSection
        } else {
            chooseFilterSection
        }
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
            ZStack(alignment: .bottom) {
                ZStack {
                    VStack(spacing: 0) {
                        pictureSection
                        Divider()
                        chooseSection()
                        Color("Background").frame(height: 50)
                    }
                    createActionButtonSection()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .offset(x: -24, y: -180)
                }
                TabBar(selectedTab: $selectedTab)
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
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func setNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            appViewModel.styledBackgroundImage = uiImage
        }
    }

    func loadImage() {
        guard let inputImage = appViewModel.styledBackgroundImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }

}
