import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var gameInfoView: GameInfoView!
    @IBOutlet var gameWonView: GameWonView!
    @IBOutlet var nameField: UITextField!
    
    private var cardDataSource: CardDataSource?
    private var cardsCollectionViewDelegete: CardsCollectionViewDelegate?
    private var cardToMatchIndex: Int = -1
    private var matches: Int = 0
    private var moves: Int = 0
    private var timer: Timer?
    private var timeCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardDataSource = CardDataSource(cards: Card.getPokemonGameCards(count: 16), cardButtonAction: self.cardButtonAction)
        cardsCollectionViewDelegete = CardsCollectionViewDelegate()
        collectionView.dataSource = cardDataSource
        collectionView.delegate = cardsCollectionViewDelegete
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    @objc func tick() {
        timeCounter += 1
        gameInfoView.configure(tries: moves, timer: timeCounter)
    }
    
    func match(cardIndex: Int, matchedIndex: Int) {
        cardDataSource?.matchCard(at: cardIndex)
        cardDataSource?.matchCard(at: matchedIndex)
        matches += 1
        
        if matches == 16 / 2 {
            timer?.invalidate()
            UIView.transition(with: gameWonView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.gameWonView.isHidden = false
            })
        }
    }
    
    func cardButtonAction(index: Int) {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.tick)), userInfo: nil, repeats: true)
        }
        
        if let card = self.cardDataSource?.cardAt(index: index) {
            
            if (self.cardToMatchIndex == -1) {
                self.cardDataSource?.flipIfNotMatched()
            }
            self.collectionView.reloadData()
            if !card.isFlipped {
                self.cardDataSource?.flipCard(at: index)
                self.collectionView.reloadData()
                if self.cardToMatchIndex == -1 {
                    self.cardToMatchIndex = index
                } else {
                    let cardToMatch = self.cardDataSource?.cardAt(index: self.cardToMatchIndex)
                    if cardToMatch?.id == card.id {
                        self.match(cardIndex: index, matchedIndex: self.cardToMatchIndex)
                    } else {
                        //self.cardDataSource?.flipIfNotMatched()
                    }
                    self.cardToMatchIndex = -1
                    
                    self.moves += 1
                    self.gameInfoView.configure(tries: self.moves, timer: self.timeCounter)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 4
        let spacing: CGFloat = 5
        let horSpacing = (columns - 1) * spacing

        let itemWidth = (collectionView.bounds.width - horSpacing) / columns

        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    
    }
}
