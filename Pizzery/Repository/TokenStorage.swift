import Combine
import SwiftUI

final class TokenStorage: ObservableObject {
    fileprivate enum Key: String { case accessToken, refreshToken }
    private var cancellables = Set<AnyCancellable>()
    static let shared = TokenStorage()

    @Published private(set) var refreshToken: Token
    @Published private(set) var accessToken: Token

    var isAuthorized: Bool { accessToken.isValid }

    func saveTokens(access: Token, refresh: Token) {
        self.refreshToken = refresh
        self.accessToken = access
    }

    func clearTokens() {
        saveTokens(access: Token(), refresh: Token())
    }

    private init() {
        refreshToken = TokenStorage.readToken(.refreshToken)
        accessToken = TokenStorage.readToken(.accessToken)
        $refreshToken.bindToken(.refreshToken, storeIn: &cancellables)
        $accessToken.bindToken(.accessToken, storeIn: &cancellables)
    }

    private static func readToken(_ key: Key) -> Token {
        return Token(
            KeychainHelper.shared.read(key.rawValue) ?? "",
            expireTime: (UserDefaults.standard.value(forKey: key.rawValue)
                as? NSNumber)?.int64Value ?? 0
        )
    }
}

extension Publisher where Output == Token, Failure == Never {
    fileprivate func bindToken(
        _ key: TokenStorage.Key,
        storeIn: inout Set<AnyCancellable>
    ) {
        let keychain = KeychainHelper.shared
        let defaults = UserDefaults.standard
        self
            .dropFirst()
            .sink { token in
                defaults.set(token.expireTime, forKey: key.rawValue)
                if token.value.isNotEmpty {
                    keychain.save(token.value, for: key.rawValue)
                } else {
                    keychain.delete(key.rawValue)
                }
            }
            .store(in: &storeIn)
    }
}
