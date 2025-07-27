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
                            text: Strings.exitStr,
                            containerColor: .mainRed.opacity(0.7),
                            contentColor: .white,
                            leadingIcon: .exit
                        ) {
                            // TODO: on exit click
                        }
                        .padding(top: 24)

                        Spacer().frame(height: 6)
                    }
                }
                .refreshable { loginVm.updateUserData() }
            } else {
                NeedAuthView()
            }
        }
        .fillMaxSize()
        .padding(horizontal: 16)
    }
}

extension ProfileScreen {

    fileprivate func accountCard(user: User) -> some View {
        HStack(spacing: 16) {
            AsyncImage(
                url: user.avatar,
                placeholderImage: .navProfile,
                placeholderColor: .white,
                placeholderPadding: 24
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
                image: .profile,
                label: Strings.accountData,
                onClick: { navController.push(.account) }
            )

            profileButton(
                image: .map,
                label: Strings.addresses,
                onClick: { navController.push(.addresses) }
            )

            profileButton(
                image: .orderPackage,
                label: Strings.orders,
                onClick: { navController.push(.orders) }
            )

            profileButton(
                image: .deleteTrash,
                label: Strings.deleteAccount,
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
        image: UIImage,
        label: String,
        onClick: @escaping () -> Void
    ) -> some View {
        Button(action: onClick) {
            HStack(spacing: 0) {
                Circle()
                    .frame(40)
                    .foregroundColor(.white)
                    .overlay {
                        Image(uiImage: image)
                            .resizable()
                            .frame(18)
                    }

                Text(label)
                    .font(.regular16, .gray32343E)
                    .lineLimit(1)
                    .padding(start: 14)

                Spacer()

                Image(.nextButton)
                    .resizable()
                    .tint(.gray32343E)
                    .frame(24)
            }
            .padding(horizontal: 20, vertical: 12)
            .background(.grayF0F2F5)
        }
    }
}
