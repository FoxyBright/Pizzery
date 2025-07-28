import SwiftUI

struct NeedAuthScreen: View {
    @EnvironmentObject
    var navController: NavController<Destination>

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 32) {
                Image(.needAuth)
                    .resizable()
                    .frame(width: 200, height: 140)
                    .tint(.mainOrange)

                Text(Strings.needAuthorization)
                    .multilineTextAlignment(.center)
                    .font(.bold20, .black)

                SolidButton(
                    text: Strings.goToAutorization,
                    trailingIcon: .arrowRight,
                    action: { navController.push(.signIn) }
                )
            }

            Spacer()

            TermsOfUse()
                .padding(vertical: 32)
        }
        .padding(horizontal: 16)
    }
}
