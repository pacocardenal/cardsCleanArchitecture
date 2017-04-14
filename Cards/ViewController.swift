import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    var deck: Deck!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paintCardPlaceholder()
        
    }

    // MARK: - User actions
    @IBAction func deckButtonClicked(_ sender: UIButton) {
        DeckInteractor(manager: DeckOfCardsApiManagerFakeImpl()).execute { (deck) in
            print(deck.deckId)
            self.deck = deck
        }
    }
    
    @IBAction func cardButtonClicked(_ sender: UIButton) {
        paintCardPlaceholder()
        GetCardFromDeckInteractor(deck: deck, manager: DeckOfCardsApiManagerFakeImpl()).execute { (card) in
            print(card.image)
            GetCardImageInteractor(card: card, manager: DeckOfCardsApiManagerFakeImpl()).execute(completion: { (image) in
                self.cardImageView.image = image
            })
        }
    }
    
    //
    func paintCardPlaceholder() {
        assert(Thread.current == Thread.main)
        
        cardImageView.image = UIImage(named: "cardBack.png")
    }
    
}

