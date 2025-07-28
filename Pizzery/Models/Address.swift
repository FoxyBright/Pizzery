struct Address: Hashable {
    let id: Int64
    let address: String
    let floor: String
    let flat: String
    let intercom: String
    let porch: String
}

let TEST_ADDRESS = Address(
    id: Int64.random(in: 0..<Int64.max),
    address: "Калужская обл., г. Киров, ул. Труда. д.54",
    floor: "13",
    flat: "124",
    intercom: "124",
    porch: "3"
)
