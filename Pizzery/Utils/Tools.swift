import SwiftUI

func openURL(_ string: String) {
    if let url = URL(string: string) {
        UIApplication.shared.open(url)
    }
}

func delay(_ millis: UInt64) async {
    try? await Task.sleep(nanoseconds: millis * 1_000_000)
}
