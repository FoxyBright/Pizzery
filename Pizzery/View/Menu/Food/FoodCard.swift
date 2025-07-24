import SwiftUI

struct FoodCard: View {
    var food: Food
    var inBasket: Bool = false
    var isFavourite: Bool = false
    var count: Int = 0
    var onLikeClick: @MainActor () -> Void = {}
    var onAddClick: @MainActor () -> Void = {}
    var onRemoveClick: @MainActor () -> Void = {}

    var body: some View {
        Button(action: onLikeClick) {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    foodImage()
                        .padding(top: 36, bottom: 10)

                    Text(food.name)
                        .font(.medium16, .black)
                        .padding(bottom: 6)

                    ingredients()
                }
                .padding(horizontal: 12)
                .padding(bottom: 10)

                addFoodBar()
            }

            .background(cardBackground)
            .overlay(alignment: .topTrailing) {
                likeButton()
                    .padding(16)
            }
        }
        .clip(30)
    }
}

extension FoodCard {
    fileprivate var cardBackground: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.turquoise)
                    .frame(height: geo.size.height * 0.4)
                    .fillMaxWidth()
                Rectangle()
                    .fill(.grayF1F4FB)
                    .frame(height: geo.size.height * 0.6)
                    .fillMaxWidth()
            }
        }
    }

    fileprivate func likeButton() -> some View {
        Button(action: onLikeClick) {
            Image(R.drawable.heart)
                .resizable()
                .tint(isFavourite ? .mainOrange : .gray828181)
                .frame(width: 16, height: 14)
                .padding(8)
        }
        .background(.white)
        .clipShape(Circle())
    }

    fileprivate func foodImage() -> some View {
        Circle()
            .fill(.mainOrange)
            .frame(110)
    }

    @ViewBuilder
    fileprivate func ingredients() -> some View {
        if food.ingredients.isNotEmpty {
            Text(food.ingredients.joined(separator: ", "))
                .font(.regular12, .gray737373)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, maxHeight: 30, alignment: .topLeading)
        } else {
            Spacer().frame(height: 30)
        }
    }

    fileprivate func addFoodBar() -> some View {
        HStack(spacing: 0) {
            Text(String(650) + "p")
                .font(.semibold18, .black)
                .padding(start: 20, end: 8)

            Spacer()

            Button(action: onAddClick) {
                Image(R.drawable.plus)
                    .resizable()
                    .tint(.white)
                    .frame(16)
                    .padding(16)
            }
            .background(count > 0 ? .mainOrange : .black)
            .clip(20, corners: [.topLeft])
        }
    }
}
