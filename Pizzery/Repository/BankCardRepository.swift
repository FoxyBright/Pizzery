import Combine
import SwiftUI

final class BankCardRepository: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let keychain = KeychainHelper.shared
    private let storeKey = "stored_cards"
    static let shared = BankCardRepository()

    @Published private(set) var cards: [Card] = []

    private init() {
        loadCards()
        $cards
            .dropFirst()
            .sink { [weak self] updatedCards in
                self?.persist(updatedCards)
            }
            .store(in: &cancellables)
    }

    func addCard(_ card: Card) {
        guard !cards.contains(where: { $0.number == card.number }) else {
            return
        }
        cards.append(card)
    }

    func removeCard(_ card: Card) {
        cards.removeAll { $0.number == card.number }
    }

    func clearAll() {
        cards.removeAll()
    }

    private func loadCards() {
        guard let data = keychain.readData(storeKey),
            let decoded = try? JSONDecoder().decode([Card].self, from: data)
        else { return }

        self.cards = decoded
    }

    private func persist(_ cards: [Card]) {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        keychain.saveData(data, for: storeKey)
    }
}
