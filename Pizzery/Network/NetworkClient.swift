import Foundation

final class NetworkClient {
    static let shared = NetworkClient()
    private init() {}

    func getAuthCode(
        phone: String
    ) async -> HttpResult<SuccessResponse> {
        return HttpResult.success(TEST_SUCCESS_RESPONSE)
    }

    func login(code: String) async -> HttpResult<User> {
        return HttpResult.success(TEST_USER)
    }

    func updateUser() async -> HttpResult<User> {
        return HttpResult.success(TEST_USER)
    }

    func logout() async -> HttpResult<SuccessResponse> {
        return HttpResult.success(TEST_SUCCESS_RESPONSE)
    }

    /// method for sendig HTTP requests
    private func sendRequest<R: Decodable>(
        _ path: String,
        method: HttpMethod = .post,
        contentType: ContentType = .ApplicationJson,
        body: Encodable? = nil
    ) async -> HttpResult<R> {
        let url = "\(Constants.API_URL)\(path)"
        print("REQUEST (\(method.rawValue)): \(url)")

        guard let urlObject = URL(string: url) else {
            return .failure("Invalid URL: \(url)").printContent()
        }

        var urlRequest = URLRequest(url: urlObject)
        urlRequest.allHTTPHeaderFields = ["Auth": "1"]
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
                        .decode(ErrorResponse.self, from: data)
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
