import SwiftUI
import AVKit

struct ItemsView: View {
    @ObservedObject var appViewModel: AppViewModel

    var item: PhotoPickerModel? {
        appViewModel.items.first
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            if item?.mediaType == .photo {
                Image(uiImage: item?.photo ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if item?.mediaType == .video {
                if let url = item?.url {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(minHeight: 200)
                } else { EmptyView() }
            } else {
                if let livePhoto = item?.livePhoto {
                    LivePhotoView(livePhoto: livePhoto)
                        .frame(minHeight: 200)
                } else { EmptyView() }
            }
        }

    }
}
