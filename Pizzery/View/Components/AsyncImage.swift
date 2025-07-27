import SDWebImageSwiftUI
import SwiftUICore

struct AsyncImage<Placeholder: View, Content: View>: View {
    private let urlString: String?
    private let placeholder: () -> Placeholder
    private let content: (Image) -> Content

    init(
        url urlString: String?,
        @ViewBuilder placeholderContent: @escaping () -> Placeholder = {
            EmptyView()
        },
        @ViewBuilder content: @escaping (Image) -> Content = { image in
            image.resizable().scaledToFill().fillMaxSize()
        }
    ) {
        self.urlString = urlString
        self.placeholder = placeholderContent
        self.content = content
    }

    init(
        url urlString: String?,
        placeholderImage: UIImage,
        placeholderColor: Color = .white,
        placeholderPadding: CGFloat = 0,
        @ViewBuilder content: @escaping (Image) -> Content = { image in
            image.resizable().scaledToFill().fillMaxSize()
        }
    ) where Placeholder == AnyView {
        self.urlString = urlString
        self.content = content
        self.placeholder = {
            AnyView(
                Image(uiImage: placeholderImage)
                    .resizable()
                    .tint(placeholderColor)
                    .scaledToFill()
                    .padding(placeholderPadding)
            )
        }
    }

    var body: some View {
        Group {
            if let urlString, let url = URL(string: urlString) {
                WebImage(url: url) { image in
                    content(image)
                } placeholder: {
                    placeholder()
                }
            } else {
                placeholder()
            }
        }
    }
}
