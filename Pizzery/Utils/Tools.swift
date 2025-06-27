import SwiftUI

func openURL(_ string: String) {
    if let url = URL(string: string) {
        UIApplication.shared.open(url)
    }
}
