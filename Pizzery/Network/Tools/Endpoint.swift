enum Endpoint {

    // MARK: Login
    case sendCode, login, tryAuth, refresh, logout

    var path: String {
        switch self {
        case .sendCode: "/auth/phone"
        case .login: "/auth/code"
        case .tryAuth: "/auth/try"
        case .refresh: "/auth/refresh"
        case .logout: "auth/logout"
        }
    }
    
    struct Parameter {
        let key: String, value: Any

        static func ID(_ id: Any) -> Parameter {
            Parameter(key: "id", value: id)
        }
    }

    func addParams(_ params: [Parameter]) -> String {
        if params.isEmpty { return path }
        var newPath: String = path
        params.indices.forEach { i in
            newPath.append(i == 0 ? "?" : "&")
            newPath.append("\(params[i].key)=\(params[i].value)")
        }
        return newPath
    }
}
