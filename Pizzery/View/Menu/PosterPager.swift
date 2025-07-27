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
                    AsyncImage(
                        url: items[index].imageUrls.first,
                        placeholderContent: {
                            Color.grayCBCBCB.opacity(0.3)
                        }
                    )
                    .clip(30)
                }
                .itemSpacing(16)
                .horizontal(.startToEnd)
                .interactive(scale: 0.9)
                .preferredItemSize(posterSize)
                .loopPages(true)
            }
        }
    }
}
