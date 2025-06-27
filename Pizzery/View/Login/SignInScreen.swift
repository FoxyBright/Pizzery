import SwiftUI

#Preview { SignInScreen().environmentObject(LoginViewModel()) }
struct SignInScreen: View {
    @EnvironmentObject var navController: NavController<Destination>
    @EnvironmentObject var loginVm: LoginViewModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text(
                loginVm.hasCode
                    ? String.resource("codeWasSentTo")
                        .appending(
                            " \(loginVm.formPhone(filterNumbers: false))"
                        )
                    : String.resource("weSendCode")
            )
            .multilineTextAlignment(.center)
            .foregroundColor(.gray828181)
            .font(.regular14)
            .padding(.top, 40)

            VStack {
                if loginVm.hasCode {
                    codeField(loginVm)
                } else {
                    phoneField(loginVm)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 28)

            Spacer()

            DefaultButton(
                text: String.resource(
                    loginVm.hasCode ? "sendCode" : "getCode"
                ),
                isLoading: loginVm.pendingCode
                    || loginVm.pendingLogin,
                enabled: !loginVm.pendingCode
                    && !loginVm.pendingLogin
                    && (loginVm.hasCode
                        ? loginVm.authCode.isNotEmpty
                        : loginVm.phoneNumber.filter { $0.isNumber }.count
                            >= loginVm.country.info.phoneSize),
                action: {
                    if loginVm.hasCode {
                        loginVm.login()
                    } else {
                        loginVm.getAuthCode()
                    }
                },
            )
            .padding(.horizontal, 16)
        }
        .background(
            ZStack {
                GradientBackground()
                BublesView()
            }
            .ignoresSafeArea()
        )
        .animation(.easeInOut(duration: 0.3), value: loginVm.hasCode)
        .onChange(of: loginVm.authorized) { authorized in
            if authorized { navController.push(.menu, reset: true) }
        }
        .onDisappear {
            loginVm.phoneNumber = ""
            loginVm.authCode = ""
            loginVm.hasCode = false
        }
    }

    @ViewBuilder
    private func codeField(_ loginVm: LoginViewModel) -> some View {
        NumberTextField(
            text: $loginVm.authCode,
            placeholder: .resource("smsCode"),
        ) { text in
            loginVm.authCode = text
        }
    }

    @ViewBuilder
    private func phoneField(_ loginVm: LoginViewModel) -> some View {
        HStack {
            Button(action: {}) {
                Text(loginVm.country.info.phoneCode)
                    .foregroundColor(.black)
                    .font(.bold17)
            }
            .buttonStyle(.plain)
            .frame(width: 54, height: 54)
            .background(.white)
            .clipped()
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.06), radius: 2, y: 1)

            NumberTextField(
                text: $loginVm.phoneNumber,
                placeholder: loginVm.country.info.phoneMask,
            ) { text in
//                let masked =
//                    text.filter { $0.isNumber }
//                    .applyMask(loginVm.country.info.phoneMask, changedChar: "_")
//                if masked != text {
//                    loginVm.phoneNumber = masked
//                }
            }
        }
    }
}

private struct NumberTextField: View {
    @Binding var text: String
    var placeholder: String
    var onTextChange: (String) -> Void

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(.numberPad)
            .foregroundColor(.black)
            .font(.bold17)
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.gray, lineWidth: 1)
                    .background(.white)
                    .cornerRadius(16)
            }
            .shadow(color: .black.opacity(0.06), radius: 2, y: 1)
            .onChange(of: text) { newValue in
                onTextChange(newValue)
            }
    }
}

private struct BublesView: View {
    @EnvironmentObject var loginVm: LoginViewModel

    var body: some View {
        GeometryReader { geo in
            let W = geo.size.width
            let H = geo.size.height

            ZStack(alignment: .top) {
                ZStack {
                    Circle()
                        .foregroundColor(.gray3E3E3E)
                        .frame(width: W * 1.25, height: W * 1.25)
                        .shadow(color: .gray, radius: 4, y: 4)
                        .offset(x: W * -0.2)
                    Circle()
                        .foregroundColor(.mainOrange)
                        .frame(width: W * 0.75, height: W * 0.75)
                        .offset(x: W * 0.3)
                }
                .offset(y: -200)
                .addSafeArea()
                .frame(maxWidth: W, maxHeight: H, alignment: .top)
                .clipped()

                Rectangle()
                    .frame(maxWidth: W, maxHeight: 65)
                    .foregroundColor(.mainOrange)

                Text(loginVm.hasCode ? "enterCode" : "enterPhoneNumber")
                    .frame(maxWidth: W, alignment: .leading)
                    .addSafeArea()
                    .foregroundColor(.white)
                    .font(.regular20)
                    .padding(.leading, 24)
                    .padding(.top, 110)

                Text("signIn")
                    .frame(maxWidth: W, alignment: .trailing)
                    .addSafeArea()
                    .foregroundColor(.white)
                    .font(.bold36)
                    .padding(50)
            }
            .frame(maxWidth: W, maxHeight: H)
        }
    }
}
