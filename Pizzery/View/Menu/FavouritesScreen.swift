import SwiftUI

struct FavouritesScreen: View {
    @State var favourites: [Int64] = []
    @State var basket: [Int64] = []

    var body: some View {
        HStack {
            Spacer().frame(width: 16)

            FoodCard(
                food: Food(
                    id: 1,
                    name: "Маргарита",
                    price: 650.00,
                    category: FoodCategory(
                        id: 0,
                        name: "Пицца",
                        imageUrl: "https://i.pinimg.com/originals/1b/b9/74/1bb974de8c8f34427973c8c48e4875ce.jpg",
                        hasSale: false,
                        isNew: true
                    ),
                    image: "https://i.pinimg.com/originals/1b/b9/74/1bb974de8c8f34427973c8c48e4875ce.jpg",
                    ingredients: ["моцарелла", "оливки", "томатная паста", "перец", "томаты", "салями"]
                ),
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

            Spacer().frame(width: 30)

            FoodCard(
                food: Food(
                    id: 2,
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
                ),
                inBasket: basket.contains(2),
                isFavourite: favourites.contains(2),
                onLikeClick: {
                    if favourites.contains(2) {
                        favourites.removeAll(where: { $0 == 2 })
                    } else {
                        favourites.append(2)
                    }
                },
                onAddClick: {
                    if basket.contains(2) {
                        basket.removeAll(where: { $0 == 2 })
                    } else {
                        basket.append(2)
                    }
                }
            )

            Spacer().frame(width: 16)
        }
    }
}
