import UIKit

class CardCell: UICollectionViewCell {
    typealias CardButtonAction = (_ : Int) -> Void
    
    @IBOutlet var cardButton: UIButton!
    
    private var cardButtonAction: CardButtonAction?
    private var card: Card?
    private var index: Int?

    func configure(index: Int, card: Card, cardButtonAction: @escaping CardButtonAction) {
        self.card = card
        if (card.isFlipped || card.isMatched) {
            let cardImage = UIImage(named: card.image)?.withRenderingMode(.alwaysOriginal) as UIImage?
            cardButton.setImage(cardImage, for: .normal)
            cardButton.backgroundColor = UIColor.white
        } else {
            cardButton.backgroundColor = UIColor.blue
            cardButton.setImage(nil, for: .normal)
        }
        self.index = index
        self.cardButtonAction = cardButtonAction
    }
    
    @IBAction func cardButtonTriggered(_ sender: UIButton) {
        self.cardButtonAction?(self.index!)
    }
}
