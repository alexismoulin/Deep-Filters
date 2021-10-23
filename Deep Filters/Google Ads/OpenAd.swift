import Foundation
import GoogleMobileAds

final class OpenAd: NSObject, GADFullScreenContentDelegate {
    var appOpenAd: GADAppOpenAd?
    var loadTime = Date()

    func requestAppOpenAd() {
        let request = GADRequest()
        GADAppOpenAd.load(withAdUnitID: Keys.adAppID,
                          request: request,
                          orientation: UIInterfaceOrientation.portrait,
                          completionHandler: { (appOpenAdIn, _) in
            self.appOpenAd = appOpenAdIn
            self.appOpenAd?.fullScreenContentDelegate = self
            self.loadTime = Date()
            print("[OPEN AD] Ad is ready")
        })
    }

    func tryToPresentAd() {
        if let gOpenAd = self.appOpenAd, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
            gOpenAd.present(fromRootViewController: (UIApplication.shared.windows.first?.rootViewController)!)
        } else {
            self.requestAppOpenAd()
        }
    }

    func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
        let secondsPerHour = 3600.0
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return intervalInHours < Double(thresholdN)
    }

    // swiftlint:disable:next identifier_name
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("[OPEN AD] Failed: \(error)")
        requestAppOpenAd()
    }

    // swiftlint:disable:next identifier_name
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        requestAppOpenAd()
        print("[OPEN AD] Ad dismissed")
    }

    // swiftlint:disable:next identifier_name
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[OPEN AD] Ad did present")
    }
}
