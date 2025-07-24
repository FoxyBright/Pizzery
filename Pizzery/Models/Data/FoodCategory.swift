import SwiftUI

struct FoodCategory: Hashable {
    let id: Int64
    let name: String
    let imageUrl: String
    let hasSale: Bool
    let isNew: Bool
}
