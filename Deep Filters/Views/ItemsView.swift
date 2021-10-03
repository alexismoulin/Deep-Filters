import SwiftUI
import AVKit

struct ItemsView: View {
    @ObservedObject var appViewModel: AppViewModel

    var body: some View {
            List(appViewModel.items, id: \.id) { item in
                ZStack(alignment: .topLeading) {
                    if item.mediaType == .photo {
                        Image(uiImage: item.photo ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if item.mediaType == .video {
                        if let url = item.url {
                            VideoPlayer(player: AVPlayer(url: url))
                                .frame(minHeight: 200)
                        } else { EmptyView() }
                    } else {
                        if let livePhoto = item.livePhoto {
                            LivePhotoView(livePhoto: livePhoto)
                                .frame(minHeight: 200)
                        } else { EmptyView() }
                    }

                    Image(systemName: getMediaImageName(using: item))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .background(Color.black.opacity(0.5))
                        .foregroundColor(.white)
            }
        }
    }

    fileprivate func getMediaImageName(using item: PhotoPickerModel) -> String {
        switch item.mediaType {
        case .photo:
            return "photo"
        case .video:
            return "video"
        case .livePhoto:
            return "livephoto"
        }
    }
}
