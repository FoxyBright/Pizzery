import SwiftUI

struct ProfileScreen: View {
    @EnvironmentObject
    var navController: NavController<Destination>
    @EnvironmentObject
    var loginVm: LoginViewModel

    var body: some View {
        Group {
            if let user = loginVm.user {
                ScrollView {
                    VStack(spacing: 24) {
                        Spacer().frame(height: 24)

                        accountCard(user: user)

                        profileActions()
                            .padding(horizontal: 8)

                        DefaultButton(
                            text: R.strings.exitStr,
                            containerColor: .mainRed.opacity(0.7),
                            contentColor: .white,
                            leadingIcon: R.drawable.exit
                        ) {
                            // TODO: on exit click
                        }
                        .padding(top: 24)

                        Spacer().frame(height: 6)
                    }
                }
                .refreshable { loginVm.updateUserData() }
            } else {
                VStack(spacing: 24) {
                    Text("Для заказа товаров необходимо авторизоваться")
                        .multilineTextAlignment(.center)
                        .font(.medium24, .black)
                        .padding(horizontal: 16)

                    DefaultButton(
                        text: "Перейти к авторизации",
                        trailingIcon: R.drawable.arrowRight
                    ) {
                        // TODO: on autorize click
                    }
                }
                .fillMaxSize()
            }
        }
        .fillMaxSize()
        .padding(horizontal: 16)
        .background(GradientBackground().ignoresSafeArea())
    }
}

extension ProfileScreen {

    fileprivate func accountCard(user: User) -> some View {
        HStack(spacing: 16) {
            AsyncPicture(
                user.avatar,
                placeholderImageName: R.drawable.navProfile
            )
            .frame(100)
            .background(.gray94A3B3)
            .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                Spacer().frame(height: 8)

                let dataToShow = [user.name, user.email, user.phone]
                    .filter { $0.isNotEmpty }

                ForEach(dataToShow.indices, id: \.self) { index in
                    accountDataRow(
                        dataToShow[index],
                        isTitle: index == 0
                    )
                }

                Spacer()
            }

            Spacer()
        }
        .fillMaxWidth(alignment: .leading)
        .padding(12)
        .background(.white)
        .clip(20)
        .shadow(color: .black.opacity(0.1), radius: 2, y: 1)
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

    private func accountDataRow(
        _ text: String,
        isTitle: Bool
    ) -> some View {
        if isTitle {
            Text(text)
                .font(.medium18, .black)
                .lineLimit(1)
        } else {
            Text(text)
                .font(.regular14, .gray828181)
                .lineLimit(1)
        }
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
}
