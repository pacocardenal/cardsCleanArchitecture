import UIKit

public class GetCardImageInteractor {
    
    let manager: DeckOfCardsApiManager
    let card: Card
    
    public init (card: Card, manager: DeckOfCardsApiManager) {
        self.card = card
        self.manager = manager
    }
    
    public convenience init(card: Card) {
        self.init(card: card, manager: DeckOfCardsApiManagerGCDImpl())
    }
    
    public func execute(completion: @escaping (UIImage) -> Void) {
        manager.downloadCardImage(card: card) { (image) in
            assert(Thread.current == Thread.main)
            
            completion(image)
        }
    }
    
}
