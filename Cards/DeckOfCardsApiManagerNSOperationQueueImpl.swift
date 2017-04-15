import UIKit

public class DeckOfCardsApiManagerNSOperationQueueImpl: DeckOfCardsApiManager {
    
    public func downloadDeck(completion: @escaping (Deck) -> Void) {
        self.downloadDeck(completion: completion, onError: nil)
    }
    
    public func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure? = nil) {
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"
        
        let queue = OperationQueue()
        queue.addOperation {
            guard let url = URL(string: urlString) else {
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let deck = Deck(deckId: cardJson["deck_id"] as! String)
                OperationQueue.main.addOperation {
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
        
        let queue = OperationQueue()
        queue.addOperation {
            guard let url = URL(string: urlString) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let cardJson = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
                let cards = cardJson["cards"] as! [Dictionary<String, Any>]
                let firstCard = cards[0]
                let card = Card(code: firstCard["code"] as! String, suit: firstCard["suit"] as! String, image: firstCard["image"] as! String)
                OperationQueue.main.addOperation {
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
        
        let queue = OperationQueue()
        queue.addOperation {
            guard let url = URL(string: urlString) else { return }
            
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else { return }
                OperationQueue.main.addOperation {
                    completion(image)
                }
            } catch {
                print("Error in downloadCardImage: " + error.localizedDescription)
            }
        }
        
        DispatchQueue.global().async {

        }
        
    }
    
}
