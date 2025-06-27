import Foundation

struct HttpResult<T> {
    private let data: T?
    private let error: ModelErrorResponse?

    private init(data: T?, error: ModelErrorResponse?) {
        self.data = data
        self.error = error
    }

    static func success(_ data: T) -> HttpResult<T> {
        return HttpResult(data: data, error: nil)
    }

    static func failure(_ error: ModelErrorResponse) -> HttpResult<T> {
        return HttpResult(data: nil, error: error)
    }

    static func failure(_ msg: String) -> HttpResult<T> {
        return HttpResult(
            data: nil,
            error: ModelErrorResponse(
                code: 0,
                message: "Inner Error",
                detail: msg
            )
        )
    }

    static func failure(_ error: Error) -> HttpResult<T> {
        return self.failure(error.localizedDescription)
    }

    func isSuccess() -> Bool { return error == nil }
    func isFailure() -> Bool { return error != nil }

    func getError() -> ModelErrorResponse? { return error }
    func getOrNull() -> T? { return data }

    @discardableResult
    func onSuccess(_ action: (T) -> Void) -> HttpResult<T> {
        if let data = data { action(data) }
        return self
    }

    @discardableResult
    func onFailure(_ action: (ModelErrorResponse) -> Void) -> HttpResult<T> {
        if let error = error { action(error) }
        return self
    }

    func getOrThrow() throws -> T {
        if let data = data {
            return data
        } else if let error = error {
            throw Errors.runtimeError(
                "Error. Code: \(error.code), "
                    + "Message: \(error.message), "
                    + "Detail: \(error.detail)"
            )
        } else {
            throw Errors.runtimeError(
                "Error: Neither data nor error is set"
            )
        }
    }

    func printContent() -> HttpResult<T> {
        if let data = data {
            print("SUCCESS: \(data)")
        } else if let error = error {
            print("ERROR: \(error)")
        }
        return self
    }
    
    private enum Errors: Error {
        case runtimeError(String)
    }
}
