import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject
    var navController: NavController<Destination>
    @EnvironmentObject
    var loginVm: LoginViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer().frame(height: 24)

                ProfileCard(user: loginVm.user)

                VStack(spacing: 0) {
                    Spacer().frame(height: 10)

                    ProfileButtonView(
                        icon: R.drawable.profile,
                        label: R.strings.accountData,
                        onClick: { navController.push(.account) }
                    )

                    ProfileButtonView(
                        icon: R.drawable.map,
                        label: R.strings.addresses,
                        onClick: { navController.push(.addresses) }
                    )

                    ProfileButtonView(
                        icon:  R.drawable.orderPackage,
                        label: R.strings.orders,
                        onClick: { navController.push(.orders) }
                    )

                    ProfileButtonView(
                        icon: R.drawable.deleteTrash,
                        label: R.strings.deleteAccount
                    ) {
                        // TODO: on delete account click
                    }

                    Spacer().frame(height: 10)
                }
                .background(.grayF0F2F5)
                .clipped()
                .cornerRadius(16)
                .padding(24)
                .shadow(color: .black.opacity(0.1), radius: 2, y: 1)

                DefaultButton(
                    text: R.strings.exitStr,
                    containerColor: .mainRed.opacity(0.7),
                    contentColor: .white,
                    leadingIcon: R.drawable.exitIcon
                ) {
                    // TODO: on exit click
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
            }
        }
        .refreshable {}
        .background(
            GradientBackground()
                .ignoresSafeArea()
        )
    }
}

private struct ProfileCard: View {
    var user: Client?

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(
                url: URL(string: /*user.avatarUrl ?? */ "")
            ) { phase in
                switch phase {
                case .empty:
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.grayF0F2F5)
                        .overlay { ProgressView() }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .cornerRadius(50)

                default:
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray828181)
                        .overlay {
                            Image(R.drawable.navProfile)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                }
            }

            Spacer().frame(width: 16)

            VStack(alignment: .leading, spacing: 8) {
                if let name = user?.firstName {
                    Text(name)
                        .foregroundColor(.black)
                        .font(.medium18)
                        .lineLimit(1)
                }
                if let email = user?.email {
                    Text(email)
                        .foregroundColor(.gray828181)
                        .font(.regular14)
                        .lineLimit(1)
                }
                if let phone = user?.phone {
                    Text(phone)
                        .foregroundColor(.gray828181)
                        .font(.regular14)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(.white)
        .clipped()
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
    }
}

private struct ProfileButtonView: View {
    var icon: String
    var label: String
    var onClick: @MainActor () -> Void

    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 0) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .overlay {
                        Image(icon)
                            .resizable()
                            .frame(width: 18, height: 18)
                    }

                Text(label)
                    .foregroundColor(.gray32343E)
                    .font(.regular16)
                    .lineLimit(1)
                    .padding(.leading, 14)

                Spacer()

                Image(R.drawable.nextButton)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray32343E)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .padding(.trailing, 20)
            .background(.grayF0F2F5)
        }
    }
}
