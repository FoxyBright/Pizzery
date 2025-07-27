import SwiftUI

#Preview { LoginScreen() }
struct LoginScreen: View {
    @EnvironmentObject var navController: NavController<Destination>

    var body: some View {
        VStack(spacing: 0) {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 260, maxHeight: 200)
                .padding(top: 90)

            Spacer()

            DefaultButton(
                text: Strings.continueStr,
                trailingIcon: .arrowRight,
                action: { navController.push(.menu, reset: true) }
            )
            .padding(horizontal: 16)
            .padding(bottom: 100)

            termsOfUse()
                .padding(horizontal: 16)
        }
        .background(
            Image(.loginBackground)
                .resizable()
                .padding(end: 24)
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

extension LoginScreen {

    fileprivate func termsOfUse() -> some View {
        ClickableText(
            text: {
                var text = AttributedString(Strings.termsOfUse)
                if let terms = text.range(of: Strings.terms) {
                    text[terms].link = URL(string: Strings.terms)
                    text[terms].foregroundColor = .mainRed
                    text[terms].underlineStyle = .single
                    text[terms].font = .semibold12
                }
                if let privacy = text.range(of: Strings.privacyPolicy) {
                    text[privacy].link = URL(string: Strings.privacyPolicy)
                    text[privacy].foregroundColor = .mainRed
                    text[privacy].underlineStyle = .single
                    text[privacy].font = .semibold12
                }
                return text
            },
            onClick: { link in
                switch link {
                case Strings.terms:
                    openURL(Constants.TERMS_OF_USE_URL)
                    break

                case Strings.privacyPolicy:
                    openURL(Constants.PRIVACY_POLICY_URL)
                    break

                default:
                    break
                }
            }
        )
        .font(.regular12, .gray828181)
        .multilineTextAlignment(.center)
    }
}
