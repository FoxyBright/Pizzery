import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject
    var navController: NavController<Destination>
    @EnvironmentObject
    var loginVm: LoginViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                accountCard()
                    .padding(top: 24)

                profileActions()
                    .padding(horizontal: 8)

                DefaultButton(
                    text: R.strings.exitStr,
                    containerColor: .mainRed.opacity(0.7),
                    contentColor: .white,
                    leadingIcon: R.drawable.exitIcon
                ) {
                    // TODO: on exit click
                }
                .padding(vertical: 24)
            }
        }
        .padding(horizontal: 16)
        .refreshable { /* TODO: on profile refresh */  }
        .background(GradientBackground().ignoresSafeArea())
    }
}

extension ProfileScreen {

    fileprivate func accountCard() -> some View {
        HStack(spacing: 0) {
            AsyncImage(
                url: URL(string: "")
            ) { phase in
                switch phase {
                case .empty:
                    Circle()
                        .frame(80)
                        .foregroundColor(.grayF0F2F5)
                        .overlay { ProgressView() }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(80)
                        .clipShape(Circle())

                default:
                    Circle()
                        .frame(80)
                        .foregroundColor(.gray828181)
                        .overlay {
                            Image(R.drawable.navProfile)
                                .resizable()
                                .tint(.white)
                                .frame(40)
                        }
                }
            }

            Spacer().frame(width: 16)

            VStack(alignment: .leading, spacing: 8) {
                if let name = loginVm.user?.firstName {
                    Text(name)
                        .font(.medium18, .black)
                        .lineLimit(1)
                }
                if let email = loginVm.user?.email {
                    Text(email)
                        .font(.regular14, .gray828181)
                        .lineLimit(1)
                }
                if let phone = loginVm.user?.phone {
                    Text(phone)
                        .font(.regular14, .gray828181)
                        .lineLimit(1)
                }
            }

            Spacer()
        }
        .fillMaxWidth(alignment: .leading)
        .padding(12)
        .background(.white)
        .clip(20)
        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
    }

    private func profileButton(
        image: String,
        label: String,
        onClick: @escaping () -> Void
    ) -> some View {
        Button(action: onClick) {
            HStack(spacing: 0) {
                Circle()
                    .frame(40)
                    .foregroundColor(.white)
                    .overlay {
                        Image(image)
                            .resizable()
                            .frame(18)
                    }

                Text(label)
                    .font(.regular16, .gray32343E)
                    .lineLimit(1)
                    .padding(start: 14)

                Spacer()

                Image(R.drawable.nextButton)
                    .resizable()
                    .tint(.gray32343E)
                    .frame(24)
            }
            .padding(horizontal: 20, vertical: 12)
            .background(.grayF0F2F5)
        }
    }

    fileprivate func profileActions() -> some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 10)

            profileButton(
                image: R.drawable.profile,
                label: R.strings.accountData,
                onClick: { navController.push(.account) }
            )

            profileButton(
                image: R.drawable.map,
                label: R.strings.addresses,
                onClick: { navController.push(.addresses) }
            )

            profileButton(
                image: R.drawable.orderPackage,
                label: R.strings.orders,
                onClick: { navController.push(.orders) }
            )

            profileButton(
                image: R.drawable.deleteTrash,
                label: R.strings.deleteAccount,
                onClick: { /* TODO: on delete account click */  }
            )

            Spacer().frame(height: 10)
        }
        .background(.grayF0F2F5)
        .clip(16)
        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
    }
}
