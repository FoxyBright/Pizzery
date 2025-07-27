import SwiftUI

#Preview { SignInScreen().environmentObject(LoginViewModel()) }
struct SignInScreen: View {
    @EnvironmentObject var navController: NavController<Destination>
    @EnvironmentObject var loginVm: LoginViewModel

    private var isButtonEnabled: Bool {
        guard !loginVm.pendingCode, !loginVm.pendingLogin else { return false }
        if loginVm.hasCode {
            return loginVm.authCode.isNotEmpty
        } else {
            let phoneNumber = loginVm.phoneNumber
                .filter { $0.isNumber }.count
            return phoneNumber >= loginVm.country.info.phoneSize
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(
                loginVm.hasCode
                    ? Strings.codeWasSentTo(
                        arg1: loginVm.formPhone(filterNumbers: false)
                    )
                    : Strings.weSendCode
            )
            .multilineTextAlignment(.center)
            .font(.regular14, .gray828181)
            .padding(top: 100, bottom: 28)

            if loginVm.hasCode {
                codeField()
            } else {
                phoneField()
            }

            DefaultButton(
                text: loginVm.hasCode
                    ? Strings.sendCode
                    : Strings.getCode,
                isLoading: loginVm.pendingCode
                    || loginVm.pendingLogin,
                enabled: isButtonEnabled,
                action: {
                    if loginVm.hasCode {
                        loginVm.login()
                    } else {
                        loginVm.getAuthCode()
                    }
                }
            )
            .padding(top: 32)
        }
        .fillMaxSize()
        .padding(horizontal: 16)
        .background(bublesBackground)
        .animation(.easeInOut(duration: 0.3), value: loginVm.hasCode)
        .onChange(of: loginVm.authorized) { authorized in
            if authorized { navController.push(.menu, reset: true) }
        }
        .onDisappear(perform: loginVm.cleanAuthData)
    }
}

extension SignInScreen {

    fileprivate var bublesBackground: some View {
        ZStack {
            GradientBackground()
            GeometryReader { geo in
                let width = geo.size.width
                ZStack(alignment: .top) {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray3E3E3E)
                            .frame(width: width * 1.25, height: width * 1.25)
                            .shadow(color: .gray, radius: 4, y: 4)
                            .offset(x: width * -0.25)
                        Circle()
                            .foregroundColor(.mainOrange)
                            .frame(width: width * 0.75, height: width * 0.75)
                            .offset(x: width * 0.3)
                    }
                    .offset(y: -width * 0.4)
                    .fillMaxHeight(alignment: .top)
                    .frame(maxWidth: width)
                    .clipped()

                    Rectangle()
                        .fillMaxWidth()
                        .frame(height: 65)
                        .foregroundColor(.mainOrange)

                    Text(
                        loginVm.hasCode
                            ? Strings.enterCode
                            : Strings.enterPhoneNumber
                    )
                    .font(.regular20, .white)
                    .fillMaxWidth(alignment: .leading)
                    .padding(top: width * 0.4, start: 24)

                    Text(Strings.signIn)
                        .font(.bold36, .white)
                        .fillMaxWidth(alignment: .trailing)
                        .padding(top: width * 0.25, end: 50)
                }
                .fillMaxSize(alignment: .top)
            }
        }
        .ignoresSafeArea()
    }

    fileprivate func codeField() -> some View {
        numberTextField(
            text: $loginVm.authCode,
            placeholder: Strings.smsCode,
            onTextChange: { loginVm.authCode = $0 }
        )
    }

    fileprivate func phoneField() -> some View {
        HStack {
            Button(action: {}) {
                Text(loginVm.country.info.phoneCode)
                    .font(.bold17, .black)
            }
            .buttonStyle(.plain)
            .frame(54)
            .background(.white)
            .clip(16)
            .shadow(color: .black.opacity(0.06), radius: 2, y: 1)

            numberTextField(
                text: $loginVm.phoneNumber,
                placeholder: loginVm.country.info.phoneMask,
            ) { text in
                let masked = text.filter { $0.isNumber }
                    .applyMask(loginVm.country.info.phoneMask, changedChar: "_")
                if masked != text { loginVm.phoneNumber = masked }
            }
        }
    }

    private func numberTextField(
        text: Binding<String>,
        placeholder: String,
        onTextChange: @escaping (String) -> Void = { _ in }
    ) -> some View {
        TextField(placeholder, text: text)
            .font(.bold17, .black)
            .keyboardType(.numberPad)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 1)
                    .background(.white)
                    .clip(16)
            }
            .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
            .onChange(of: text.wrappedValue, perform: onTextChange)
    }
}
