import Combine
import SwiftUI

final class BankCardRepository: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let keychain = KeychainHelper.shared
    private let selectedKey = "selected_card_number"
    private let storeKey = "stored_cards"
    static let shared = BankCardRepository()

    @Published private(set) var selectedCard: Card? = nil
    @Published private(set) var cards: [Card] = []

    private init() {
        loadCards()
        loadSelectedCard()

        $cards
            .dropFirst()
            .sink { [weak self] updatedCards in
                self?.persist(updatedCards)
            }
            .store(in: &cancellables)
        $selectedCard
            .dropFirst()
            .sink { [weak self] card in
                self?.persistSelection(card)
            }
            .store(in: &cancellables)
    }

    func addCard(_ card: Card) {
        guard !cards.contains(where: { $0.number == card.number }) else {
            return
        }
        cards.append(card)
    }

    func selectCard(_ card: Card?) {
        guard let card,
            cards.contains(where: { $0.number == card.number })
        else {
            selectedCard = nil
            return
        }
        selectedCard = card
    }

    func removeCard(_ card: Card) {
        cards.removeAll { $0.number == card.number }
        if selectedCard?.number == card.number {
            selectedCard = nil
        }
    }

    func clearAll() {
        cards.removeAll()
        selectedCard = nil
    }

    private func loadCards() {
        guard let data = keychain.readData(storeKey),
            let decoded = try? JSONDecoder().decode([Card].self, from: data)
        else { return }

        self.cards = decoded
    }

    private func loadSelectedCard() {
        guard let data = keychain.readData(selectedKey),
            let number = String(data: data, encoding: .utf8),
            let saved = cards.first(where: { $0.number == number })
        else { return }

        selectedCard = saved
    }

    private func persist(_ cards: [Card]) {
        guard let data = try? JSONEncoder().encode(cards) else { return }
        keychain.saveData(data, for: storeKey)
    }

    private func persistSelection(_ card: Card?) {
        guard let card else {
            keychain.delete(selectedKey)
            return
        }
        keychain.save(String(card.number), for: selectedKey)
    }
}
