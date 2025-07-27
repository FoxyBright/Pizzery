struct ErrorResponse: Hashable, Decodable {
    let code: Int
    let message: String
    let detail: String
}
