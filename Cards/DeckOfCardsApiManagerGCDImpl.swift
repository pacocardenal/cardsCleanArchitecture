import UIKit

public class DeckOfCardsApiManagerGCDImpl: DeckOfCardsApiManager {
    
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else {
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let deck = Deck(deckId: cardJson["deck_id"] as! String)
                DispatchQueue.main.async {
                    completion(deck)
                }
            } catch {
                print("Error in downloadDeck " + error.localizedDescription)
                if let errorClosure = onError {
                    errorClosure(error)
                }
            }
        }

    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void) {
        self.downloadCard(deck: deck, completion: completion, onError: nil)
    }
    
    public func downloadCard(deck: Deck, completion: @escaping (Card) -> Void, onError: ErrorClosure? = nil) {
        let urlString = "https://deckofcardsapi.com/api/deck/\(deck.deckId)/draw/?count=1"
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let cards = cardJson["cards"] as! [Dictionary<String, Any>]
                let firstCard = cards[0]
                let card = Card(code: firstCard["code"] as! String, suit: firstCard["suit"] as! String, image: firstCard["image"] as! String)
                DispatchQueue.main.async {
                    completion(card)
                }
            } catch {
                print("Error in downloadCard: " + error.localizedDescription)
                if let errorClosure = onError {
                    errorClosure(error)
                }
            }
        }
        
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void) {
        self.downloadCardImage(card: card, completion: completion, onError: nil)
    }
    
    public func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void, onError: ErrorClosure? = nil) {
        let urlString = card.image
        
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completion(image)
                }
            } catch {
                print("Error in downloadCardImage: " + error.localizedDescription)
            }
        }

    }
    
}
