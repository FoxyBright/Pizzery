import SwiftUI
import SwiftUIPager

#Preview { MenuScreen() }
struct MenuScreen: View {
    @EnvironmentObject var navController: NavController<Destination>
    @EnvironmentObject var mainVm: MainViewModel

    @State private var posterPage: Page = .first()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                SearchBar(text: $mainVm.searchText) { text in
                    mainVm.searchText = text
                }
                .padding(horizontal: 16)
                .padding(top: 46)

                logo()
                    .padding(horizontal: 16)
                    .padding(vertical: 12)

                postersPager()
                    .padding(bottom: mainVm.posters.isEmpty ? 0 : 32)

                if mainVm.pendingMenuCategories
                    && mainVm.menuCategories.isEmpty
                {
                    ProgressView()
                        .padding(top: 40)
                } else {
                    menuCategoriesGrid { category in
                        // TODO: on category click
                    }
                    .padding(horizontal: 24)
                }

                Spacer().frame(height: 30)
            }.animation(
                .easeInOut(duration: 1),
                value: mainVm.posters.isNotEmpty
            )
        }
        .refreshable { mainVm.getMenuData(isRefresh: true) }
        .onAppear { mainVm.getMenuData() }
        .background(
            GradientBackground()
                .ignoresSafeArea()
        )
    }
}

extension MenuScreen {

    @ViewBuilder
    fileprivate func logo() -> some View {
        let gradient = LinearGradient(
            colors: [.secondaryOrange, .mainOrange],
            startPoint: .leading,
            endPoint: .trailing
        )
        Text(Strings.hotDaddyPizza)
            .font(.regular24, gradient)
    }

    fileprivate func postersPager() -> some View {
        PosterPager(mainVm.posters, page: $posterPage)
            .frame(height: mainVm.posters.isEmpty ? 0 : 150)
            .clipped()
            .animation(
                .easeInOut(duration: 0.4),
                value: mainVm.posters.isEmpty
            )
    }

    @ViewBuilder
    fileprivate func menuCategoriesGrid(
        onCategoryClick: @escaping (FoodCategory) -> Void
    ) -> some View {
        let cell = GridItem(.flexible(), spacing: 20)
        LazyVGrid(columns: [cell, cell], spacing: 14) {
            ForEach(mainVm.menuCategories, id: \.self) { item in
                FoodCategoryCard(category: item) {
                    onCategoryClick(item)
                }
            }
        }
    }
}
