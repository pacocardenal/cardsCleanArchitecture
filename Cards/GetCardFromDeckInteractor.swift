import Foundation

public class GetCardFromDeckInteractor {
    
    let deck: Deck
    
    public init(deck: Deck) {
        self.deck = deck
    }
    
    public func execute(completion: @escaping (Card) -> Void) {
        
        DeckOfCardsApiManager().downloadCard(deck: deck) {(card) in
            assert(Thread.current == Thread.main)
            
            completion(card)
        }
        
    }
    
}
