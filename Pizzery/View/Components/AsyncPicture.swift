import SwiftUI

struct AsyncPicture<
    PendingContent: View,
    PlaceholderContent: View
>: View {

    let urlString: String?
    private let pendingContent: () -> PendingContent
    private let placeholderContent: () -> PlaceholderContent

    init(
        _ urlString: String?,
        @ViewBuilder pendingContent:
            @escaping () -> PendingContent = {
                ProgressView().fillMaxSize(alignment: .center)
            },
        @ViewBuilder placeholderContent:
            @escaping () -> PlaceholderContent = {
                EmptyView()
            }
    ) {
        self.urlString = urlString
        self.pendingContent = pendingContent
        self.placeholderContent = placeholderContent
    }

    init(
        _ urlString: String?,
        placeholderImageName: String,
        placeholderColor: Color = .white,
        placeholderPadding: CGFloat = 24,
        @ViewBuilder pendingContent: @escaping () -> PendingContent = {
            ProgressView().fillMaxSize(alignment: .center)
        }
    ) where PlaceholderContent == AnyView {
        self.urlString = urlString
        self.pendingContent = pendingContent
        self.placeholderContent = {
            AnyView(
                Image(placeholderImageName)
                    .resizable()
                    .tint(placeholderColor)
                    .fillMaxSize()
                    .padding(placeholderPadding)
            )
        }
    }

    var body: some View {
        Group {
            if let url = urlString {
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .empty: pendingContent()

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .fillMaxSize()

                    default: placeholderContent()
                    }
                }
            } else {
                placeholderContent()
            }
        }
        .animation(
            .easeInOut(duration: 0.3),
            value: urlString
        )
    }
}
