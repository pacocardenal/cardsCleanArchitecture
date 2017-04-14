import Foundation

public class GetCardFromDeckInteractor {
    
    let manager: DeckOfCardsApiManager
    let deck: Deck
    
    public init(deck: Deck, manager: DeckOfCardsApiManager) {
        self.deck = deck
        self.manager = manager
    }
    
    public convenience init(deck: Deck) {
        self.init(deck: deck, manager: DeckOfCardsApiManagerGCDImpl())
    }
    
    public func execute(completion: @escaping (Card) -> Void) {
        manager.downloadCard(deck: deck) {(card) in
            assert(Thread.current == Thread.main)
            
            completion(card)
        }
        
    }
    
}
