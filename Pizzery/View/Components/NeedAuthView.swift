import SwiftUI

struct NeedAuthView: View {
    @EnvironmentObject
    var navController: NavController<Destination>
    
    var body: some View {
        VStack(spacing: 24) {
            Text(Strings.needAuthorization)
                .multilineTextAlignment(.center)
                .font(.medium24, .black)
                .padding(horizontal: 16)

            DefaultButton(
                text: Strings.goToAutorization,
                trailingIcon: .arrowRight
            ) {
                navController.push(.signIn)
            }
        }
        .fillMaxSize()
    }
}
