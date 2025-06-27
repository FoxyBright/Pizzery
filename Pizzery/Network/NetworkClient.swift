import Foundation

final class NetworkClient {
    static let shared = NetworkClient()
    private init() {}

    func getAuthCode(
        phone: String
    ) async -> HttpResult<SuccessResponse> {
        return await sendRequest(
            Endpoint.sendCode.path,
            body: AuthPhoneRequest(phone: phone)
        )
    }

    func login(
        code: String
    ) async -> HttpResult<AuthResponse> {
        return await sendRequest(
            Endpoint.login.path,
            body: AuthCodeRequest(code: code)
        )
    }

    func updateUser() async -> HttpResult<AuthResponse> {
        return await sendRequest(Endpoint.tryAuth.path)
    }

    func logout() async -> HttpResult<SuccessResponse> {
        TokenStorage.shared.clearTokens()
        return await sendRequest(Endpoint.logout.path)
    }

    private func sendRequest<R: Decodable>(
        _ path: String,
        method: HttpMethod = .post,
        contentType: ContentType = .ApplicationJson,
        body: Encodable? = nil
    ) async -> HttpResult<R> {
        print("REQUEST (\(method.rawValue)): \(API_URL)\(path)")

        guard let urlObject = URL(string: "\(API_URL)\(path)") else {
            return .failure("Invalid URL: \(API_URL)\(path)").printContent()
        }

        var urlRequest = URLRequest(url: urlObject)
        urlRequest.allHTTPHeaderFields = ["Loyalty-Auth": "1"]
        urlRequest.httpMethod = method.rawValue

        if let request = body {
            do {
                urlRequest.setValue(
                    contentType.rawValue,
                    forHTTPHeaderField: "Content-Type"
                )
                let jsonData = try JSONEncoder().encode(request)
                urlRequest.httpBody = jsonData
                print("BODY: \(request)")
            } catch {
                return .failure(error).printContent()
            }
        }

        do {
            let (data, response) = try await URLSession.shared
                .data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure("No response from server").printContent()
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                do {
                    let error = try JSONDecoder()
                        .decode(ModelErrorResponse.self, from: data)
                    return .failure(error).printContent()
                } catch {
                    return .failure(error).printContent()
                }
            }

            do {
                let result = try JSONDecoder()
                    .decode(R.self, from: data)
                return .success(result).printContent()
            } catch {
                return .failure(error).printContent()
            }
        } catch {
            return .failure(error).printContent()
        }
    }
}
