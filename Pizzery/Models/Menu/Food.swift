struct Food: Hashable {
    let id: Int64
    let name: String
    let price: Double
    let category: FoodCategory
    let image: String
    let ingredients: [String]
}

let TEST_FOOD = Food(
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
