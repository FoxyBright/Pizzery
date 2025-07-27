struct User: Hashable {
    let id: Int64
    let name: String
    let email: String
    let phone: String
    let avatar: String?
    let bonusBalance: Int64
}

let TEST_USER = User(
    id: Int64.random(in: .min ... .max),
    name: "Ivanov Ivan",
    email: "test@test.com",
    phone: "+79123456789",
    avatar:
        "https://sun9-73.userapi.com/impg/c854424/v854424634/237236/kw29-eXYji0.jpg?size=604x363&quality=96&sign=a31c267273d02a2e5339237e3b34de4d&type=album",
    bonusBalance: 134
)
