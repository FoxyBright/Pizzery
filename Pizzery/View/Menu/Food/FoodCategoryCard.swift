import SwiftUI

struct FoodCategoryCard: View {
    let category: FoodCategory
    var onClick: @MainActor () -> Void

    var body: some View {
        Button(action: onClick) {
            VStack(spacing: 12) {
                AsyncImage(
                    url: category.imageUrl,
                    placeholderImage: .foodPlaceholder,
                    placeholderColor: .grayCBCBCB
                )
                .frame(100)
                .clipShape(Circle())
                .padding(top: 10)

                Text(category.name)
                    .multilineTextAlignment(.center)
                    .font(.bold16, .white)
                    .fillMaxWidth(alignment: .center)
                    .padding(16)
                    .background(.mainOrange)
                    .clip(50)
            }
        }
        .fillMaxWidth()
        .background(GradientBackground())
        .clip(20)
        .overlay(alignment: .topTrailing) {
            if category.hasSale {
                Image(.sale)
                    .frame(50)
                    .offset(x: 10, y: -10)
            }
        }
        .overlay(alignment: .topLeading) {
            if category.isNew {
                Image(.newBadge)
                    .frame(40)
                    .offset(x: -10)
            }
        }
        .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
    }
}
