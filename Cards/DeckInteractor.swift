import Foundation

public class DeckInteractor {
    let manager: DeckOfCardsApiManager
    
    public init(manager: DeckOfCardsApiManager) {
        self.manager = manager
    }
    
    public convenience init() {
        self.init(manager: DeckOfCardsApiManagerGCDImpl())
    }
    
    public func execute(completion: @escaping (Deck) -> Void) {
        manager.downloadDeck { (deck) in
            assert(Thread.current == Thread.main)
            
            completion(deck)
        }
    }
    
}
