import SwiftUI

#Preview { LoginScreen() }
struct LoginScreen: View {
    @EnvironmentObject var navController: NavController<Destination>

    var body: some View {
        VStack(spacing: 0) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 260, maxHeight: 200)
                .padding(.top, 90)

            Spacer()

            DefaultButton(
                text: String.resource("continue"),
                trailingIcon: "arrowRight",
                action: {
                    navController.push(
                        .menu,
                        reset: true,
                        animated: false
                    )
                },
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 100)

            TermsOfUseView(
                onTermsClick: {
                    openURL(TERMS_OF_USE_URL)
                },
                onPrivacyPolicyClick: {
                    openURL(PRIVACY_POLICY_URL)
                }
            )
            .padding(.horizontal, 16)
        }
        .background(
            ZStack {
                GradientBackground()
                Image("loginBackground")
                    .resizable()
                    .padding(.trailing, 24)
                    .scaledToFill()
            }
            .ignoresSafeArea()
        )
    }
}

private struct TermsOfUseView: View {
    var onTermsClick: @MainActor () -> Void
    var onPrivacyPolicyClick: @MainActor () -> Void
    var body: some View {
        ClickableText(
            text: {
                var text = AttributedString(String.resource("termsOfUse"))
                if let terms = text.range(
                    of: String.resource("terms")
                ) {
                    text[terms].link = URL(string: "terms")
                    text[terms].foregroundColor = .mainRed
                    text[terms].underlineStyle = .single
                    text[terms].font = .semibold12
                }
                if let privacy = text.range(
                    of: String.resource("privacyPolicy")
                ) {
                    text[privacy].link = URL(string: "privacy")
                    text[privacy].foregroundColor = .mainRed
                    text[privacy].underlineStyle = .single
                    text[privacy].font = .semibold12
                }
                return text
            },
            onClick: { link in
                switch link {
                case "terms":
                    onTermsClick()
                    break

                case "privacy":
                    onPrivacyPolicyClick()
                    break

                default:
                    break
                }
            }
        )
        .multilineTextAlignment(.center)
        .foregroundColor(.gray828181)
        .font(.regular12)
    }
}
