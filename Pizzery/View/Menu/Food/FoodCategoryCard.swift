import SwiftUI

struct FoodCategoryCard: View {
    let category: FoodCategory
    var onClick: @MainActor () -> Void

    var body: some View {
        Button(action: onClick) {
            ZStack {
                VStack(spacing: 12) {
                    categoryImage()
                        .padding(top: 10)

                    categoryName()
                }
            }
        }
        .fillMaxWidth()
        .background(GradientBackground())
        .clip(20)
        .overlay(alignment: .topTrailing) {
            if category.hasSale {
                Image(R.drawable.sale)
                    .frame(50)
                    .offset(x: 10, y: -10)
            }
        }
        .overlay(alignment: .topLeading) {
            if category.isNew {
                Image(R.drawable.newBadge)
                    .frame(40)
                    .offset(x: -10)
            }
        }
        .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
    }
}

extension FoodCategoryCard {

    fileprivate func categoryImage() -> some View {
        AsyncPicture(
            category.imageUrl,
            placeholderImageName: R.drawable.foodPlaceholder
        )
        .frame(100)
        .background(.grayCBCBCB)
        .clipShape(Circle())
    }

    fileprivate func categoryName() -> some View {
        ZStack(alignment: .center) {
            Text(category.name)
                .multilineTextAlignment(.center)
                .font(.bold16, .white)
        }
        .fillMaxWidth(alignment: .center)
        .padding(16)
        .background(.mainOrange)
        .clip(50)
    }

    fileprivate func saleIcon() -> some View {
        Image(R.drawable.sale)
    }
}
