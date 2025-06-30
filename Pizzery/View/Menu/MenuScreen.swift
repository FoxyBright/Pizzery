import SwiftUI

#Preview { MenuScreen() }
struct MenuScreen: View {
    @EnvironmentObject var navController: NavController<Destination>
    @EnvironmentObject var mainVm: MainViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SearchBar(text: $mainVm.searchText) { text in
                    mainVm.searchText = text
                }
                .padding(.horizontal, 16)
                .padding(.top, 46)
            }

            Text(R.strings.hotDaddyPizza)
                .font(.regular24)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.secondaryOrange, .mainOrange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.top, 12)

            ImagePagerView(
                posters: [
                    TEST_POSTER, TEST_POSTER,
                    TEST_POSTER, TEST_POSTER,
                ]
            )
        }
        .refreshable {}
        .background(
            GradientBackground()
                .ignoresSafeArea()
        )
    }
}

struct ImagePagerView: View {
    let posters: [Poster]
    @State private var selectedPage = 0

    var body: some View {
        //        TabView(selection: $selectedPage) {
        //            ForEach(posters.indices, id: \.self) { index in
        //                if let imageUrl = posters[index].imageUrls?.first {
        //                    AsyncImage(url: URL(string: imageUrl)) { phase in
        //                        switch phase {
        //                        case .empty:
        //                            ProgressView()
        //                                .frame(maxWidth: .infinity, maxHeight: .infinity)
        //                                .background(.gray.opacity(0.1))
        //                        case .success(let image):
        //                            image
        //                                .resizable()
        //                                .scaledToFill()
        //                                .frame(height: 200)
        //                                .clipped()
        //                                .cornerRadius(20)
        //                                .padding(.horizontal)
        //                        case .failure: Color.red
        //                        @unknown default:
        //                            EmptyView()
        //                        }
        //                    }
        //                    .tag(index)
        //                }
        //            }
        //        }
        //        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        //        .frame(height: 220)
    }
}

private let TEST_POSTER = Poster(
    id: Int64.random(in: 0...Int64.max),
    imageUrls: [
        "https://sun9-73.userapi.com/impg/c854424/v854424634/237236/kw29-eXYji0.jpg?size=604x363&quality=96&sign=a31c267273d02a2e5339237e3b34de4d&type=album"
    ],
    imageQty: 1,
    visible: true
)
