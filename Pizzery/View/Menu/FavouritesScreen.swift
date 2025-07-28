import SwiftUI

struct FavouritesScreen: View {
    @EnvironmentObject
    private var loginVm: LoginViewModel
    
    @State var favourites: [Int64] = []
    @State var basket: [Int64] = []

    var body: some View {
        if loginVm.user != nil {
            FoodCard(
                food: TEST_FOOD,
                inBasket: basket.contains(1),
                isFavourite: favourites.contains(1),
                onLikeClick: {
                    if favourites.contains(1) {
                        favourites.removeAll(where: { $0 == 1 })
                    } else {
                        favourites.append(1)
                    }
                },
                onAddClick: {
                    if basket.contains(1) {
                        basket.removeAll(where: { $0 == 1 })
                    } else {
                        basket.append(1)
                    }
                }
            )
        } else {
            NeedAuthScreen()
        }
    }
}

private let TEST_FOOD = Food(
    id: Int64.random(in: 0..<Int64.max),
    name: "Маргарита",
    price: 650.00,
    category: FoodCategory(
        id: 0,
        name: "Пицца",
        imageUrl: "https://i.pinimg.com/originals/1b/b9/74/1bb974de8c8f34427973c8c48e4875ce.jpg",
        hasSale: true,
        isNew: false
    ),
    image: "https://i.pinimg.com/originals/1b/b9/74/1bb974de8c8f34427973c8c48e4875ce.jpg",
    ingredients: ["food"]
)
