import Foundation

struct OrderInfo {
    let id: Int64
    let status: OrderStatus
    let number: String
    let createdAt: Int64
    let composition: [(food: Food, count: Int)]
}

enum OrderStatus: CaseIterable {
    case created,
        processing,
        shipped,
        delivered,
        cancelled,
        finished
}

let TEST_ORDER = OrderInfo(
    id: Int64.random(in: 0..<Int64.max),
    status: .delivered,
    number: "BNA4607-114VR",
    createdAt: Date().millis,
    composition: [
        (TEST_FOOD, 14),
        (TEST_FOOD, 12),
        (TEST_FOOD, 11),
        (TEST_FOOD, 2),
        (TEST_FOOD, 125),
        (TEST_FOOD, 51),
    ]
)
