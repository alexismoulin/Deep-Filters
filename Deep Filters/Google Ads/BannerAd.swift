import SwiftUI

struct BannerAd: View {
    var body: some View {
        VStack {
            Divider()
            HStack {
                Spacer()
                GADBannerViewController().frame(width: 320, height: 50, alignment: .center)
                Spacer()
            }
            Divider()
        }
    }
}
