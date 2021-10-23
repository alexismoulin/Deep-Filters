import SwiftUI
import GoogleMobileAds

struct GADBannerViewController: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> some UIViewController {
        let view = GADBannerView(adSize: GADAdSizeBanner)
        let viewController = UIViewController()

        // Banner Ad
        _ = "ca-app-pub-3940256099942544/2934735716" // test id
        view.adUnitID = Keys.adBannerID
        view.rootViewController = viewController

        // View Controller
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: GADAdSizeBanner.size)

        // Load an Add
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
