import UIKit

public class DeckOfCardsApiManagerFakeImpl: DeckOfCardsApiManager {
    
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let deck = Deck(deckId: "2222")
        completion(deck)
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void) {
        self.downloadCard(deck: deck, completion: completion, onError: nil)
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void, onError: ErrorClosure? = nil) {
        let card = Card(code: "22", suit: "spades", image: "http://")
        completion(card)
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void) {
        self.downloadCardImage(card: card, completion: completion, onError: nil)
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void, onError: ErrorClosure? = nil) {
        let image = UIImage(named: "cardBack")
        completion(image!)
    }
    
}
