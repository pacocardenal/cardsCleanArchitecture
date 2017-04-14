import Foundation

public class DeckInteractor {
    
    public func execute(completion: @escaping (Deck) -> Void) {
        DeckOfCardsApiManager().downloadDeck { (deck) in
            assert(Thread.current == Thread.main)
            
            completion(deck)
        }
    }
    
}
