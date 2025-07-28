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

            SolidButton(
                text: Strings.continueStr,
                trailingIcon: .arrowRight,
                action: { navController.push(.menu, reset: true) }
            )
            .padding(horizontal: 16)
            .padding(bottom: 100)

            TermsOfUse()
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
