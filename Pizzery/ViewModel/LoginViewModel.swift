import SwiftUI

class LoginViewModel: ObservableObject {

    // MARK: login data
    @Published var authorized: Bool = false
    @Published var phoneNumber: String = "(999) 999-99-99"
    @Published var country: Country = .RU
    @Published var authCode: String = ""
    @Published var hasCode: Bool = false

    // MARK: User data
    @Published var user: User? = TEST_USER

    // MARK: Loading states
    @Published var pendingCode = false
    @Published var pendingLogin = false

    func getAuthCode() {
        guard phoneNumber.isNotEmpty else { return }
        pendingCode = true
        Task {
            let response = await NetworkClient.shared
                .getAuthCode(phone: formPhone(filterNumbers: true))
            await MainActor.run {
                response.onSuccess { response in
                    self.hasCode = true
                }
                pendingCode = false
            }
        }
    }

    func login() {
        guard authCode.isNotEmpty, phoneNumber.isNotEmpty else { return }
        pendingLogin = true
        Task {
            let response = await NetworkClient.shared
                .login(code: authCode)
            await MainActor.run {
                response.onSuccess { response in
                    self.user = response
                    self.authorized = true
                    self.phoneNumber = ""
                    self.authCode = ""
                }
                pendingLogin = false
            }
        }
    }

    func updateUserData() {

    }

    func cleanAuthData() {
        phoneNumber = ""
        authCode = ""
        hasCode = false
    }

    func logout() {
        Task { await NetworkClient.shared.logout() }
    }

    func formPhone(filterNumbers: Bool) -> String {
        let phone = "\(country.info.phoneCode)\(phoneNumber)"
        return if filterNumbers {
            "\(phone.filter { $0.isNumber })"
        } else {
            phone
        }
    }
}
