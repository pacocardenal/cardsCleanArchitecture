import UIKit

public class GetCardImageInteractor {
    
    let card: Card
    
    public init (card: Card) {
        self.card = card
    }
    
    public func execute(completion: @escaping (UIImage) -> Void) {
        DeckOfCardsApiManagerGCDImpl().downloadCardImage(card: card) { (image) in
            assert(Thread.current == Thread.main)
            
            completion(image)
        }
    }
    
}
