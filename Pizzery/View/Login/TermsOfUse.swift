import SwiftUI

struct TermsOfUse: View {
    var body: some View {
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
