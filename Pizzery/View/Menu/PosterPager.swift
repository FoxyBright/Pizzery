import SwiftUI
import SwiftUIPager

struct PosterPager: View {
    let items: [Poster]
    @Binding var page: Page

    init(_ items: [Poster], page: Binding<Page>) {
        self.items = items
        self._page = page
    }

    var body: some View {
        if items.isNotEmpty {
            GeometryReader { geo in
                let posterSize = CGSize(
                    width: geo.size.width * 0.8,
                    height: geo.size.height
                )

                Pager(
                    page: page,
                    data: items.indices,
                    id: \.self,
                ) { index in
                    let img = items[index]
                        .imageUrls?.first
                    posterCard(img)
                        .clip(30)
                }
                .itemSpacing(16)
                .horizontal(.startToEnd)
                .interactive(scale: 0.9)
                .preferredItemSize(posterSize)
                .loopPages(true)
                .fillMaxSize()
            }
        }
    }
}

extension PosterPager {

    @ViewBuilder
    fileprivate func posterCard(_ imageUrl: String?) -> some View {
        if let imageUrl = imageUrl {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty: posterLoadingView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .fillMaxSize()

                default: posterCardPlaceholcer()
                }
            }
        } else {
            posterCardPlaceholcer()
        }
    }

    fileprivate func posterLoadingView() -> some View {
        ProgressView()
            .fillMaxSize()
            .background(.grayCBCBCB.opacity(0.3))
    }

    fileprivate func posterCardPlaceholcer() -> some View {
        Rectangle()
            .fillMaxSize()
            .foregroundColor(.grayCBCBCB.opacity(0.3))
    }
}
