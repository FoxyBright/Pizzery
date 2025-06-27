enum Country {
    case RU

    var info: CountryInfo {
        switch self {
        case .RU:
            return CountryInfo(
                phoneCode: "+7",
                phoneMask: "(___) ___-__-__",
                phoneSize: 10,
                language: "ru",
                flag: "🇷🇺"
            )
        }
    }

    struct CountryInfo {
        let phoneCode: String
        let phoneMask: String
        let phoneSize: Int
        let language: String
        let flag: String

        init(
            phoneCode: String,
            phoneMask: String,
            phoneSize: Int,
            language: String,
            flag: String,
        ) {
            self.phoneCode = phoneCode
            self.phoneMask = phoneMask
            self.phoneSize = phoneSize
            self.language = language
            self.flag = flag
        }
    }
}
