import UIKit

public typealias ErrorClosure = (Error) -> Void

public protocol DeckOfCardsApiManager {
    
    func downloadDeck(completion: @escaping (Deck) -> Void)
    /// Download a deck in JSON format from deckofcardsapi.com
    ///
    /// - Parameters:
    ///   - completion: closure with deck data
    ///   - onError: closure with error
    /// - Returns: nohting
    func downloadDeck(completion: @escaping (Deck) -> Void, onError: ErrorClosure?)
    
    func downloadCard(deck: Deck, completion: @escaping (Card) -> Void)
    func downloadCard(deck: Deck, completion: @escaping (Card) -> Void, onError: ErrorClosure?)
    
    func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void)
    func downloadCardImage(card: Card, completion: @escaping (UIImage) -> Void, onError: ErrorClosure?)
    
}
