import SwiftUI

#Preview { LoginScreen() }
struct LoginScreen: View {
    @EnvironmentObject var navController: NavController<Destination>

    var body: some View {
        VStack(spacing: 0) {
            Image(R.drawable.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 260, maxHeight: 200)
                .padding(.top, 90)

            Spacer()

            DefaultButton(
                text: R.strings.continueStr,
                trailingIcon: R.drawable.arrowRight,
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
                Image(R.drawable.loginBackground)
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
                var text = AttributedString(R.strings.termsOfUse)
                if let terms = text.range(of: R.strings.terms) {
                    text[terms].link = URL(string: R.strings.terms)
                    text[terms].foregroundColor = .mainRed
                    text[terms].underlineStyle = .single
                    text[terms].font = .semibold12
                }
                if let privacy = text.range(of: R.strings.privacyPolicy) {
                    text[privacy].link = URL(string: R.strings.privacyPolicy)
                    text[privacy].foregroundColor = .mainRed
                    text[privacy].underlineStyle = .single
                    text[privacy].font = .semibold12
                }
                return text
            },
            onClick: { link in
                switch link {
                case R.strings.terms:
                    onTermsClick()
                    break

                case R.strings.privacyPolicy:
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
