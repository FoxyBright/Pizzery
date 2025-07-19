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
            Spacer()

            Text(
                loginVm.hasCode
                    ? R.strings.codeWasSentTo
                        .appending(" ")
                        .appending(loginVm.formPhone(filterNumbers: false))
                    : R.strings.weSendCode
            )
            .multilineTextAlignment(.center)
            .font(.regular14, .gray828181)
            .padding(top: 40)

            VStack {
                if loginVm.hasCode {
                    codeField()
                } else {
                    phoneField()
                }
            }
            .padding(horizontal: 16)
            .padding(top: 28)

            Spacer()

            DefaultButton(
                text: loginVm.hasCode
                    ? R.strings.sendCode
                    : R.strings.getCode,
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
            .padding(horizontal: 16)
        }
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
                            .offset(x: width * -0.2)
                        Circle()
                            .foregroundColor(.mainOrange)
                            .frame(width: width * 0.75, height: width * 0.75)
                            .offset(x: width * 0.3)
                    }
                    .offset(y: -200)
                    .addSafeArea()
                    .fillMaxSize(alignment: .top)
                    .clipped()

                    Rectangle()
                        .frame(maxWidth: width, maxHeight: 65)
                        .foregroundColor(.mainOrange)

                    Text(
                        loginVm.hasCode
                            ? R.strings.enterCode
                            : R.strings.enterPhoneNumber
                    )
                    .font(.regular20, .white)
                    .fillMaxWidth(alignment: .trailing)
                    .addSafeArea()
                    .padding(top: 110, start: 24)

                    Text(R.strings.signIn)
                        .font(.bold36, .white)
                        .fillMaxWidth(alignment: .trailing)
                        .addSafeArea()
                        .padding(50)
                }
                .fillMaxSize()
            }
        }
        .ignoresSafeArea()
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

    fileprivate func codeField() -> some View {
        numberTextField(
            text: $loginVm.authCode,
            placeholder: R.strings.smsCode,
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
}
