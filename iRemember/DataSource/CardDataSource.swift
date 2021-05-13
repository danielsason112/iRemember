import UIKit

class CardDataSource: NSObject {
    typealias CardButtonAction = (_ index: Int) -> Void
    
    let cellIdentifier = "CardCellIdentifier"
    
    var cards: [Card]
    var cardButtonAction: CardButtonAction?
    
    func matchCard(at index: Int) {
            cards[index].isMatched = true
    }
    
    func flipCard(at index: Int) {
        cards[index].isFlipped.toggle()
    }
    
    func cardAt(index: Int) -> Card {
        return cards[index]
    }
    
    func flipIfNotMatched() {
        for i in cards.indices {
            if !cards[i].isMatched {
                cards[i].isFlipped = false
            }
        }
    }
    
    init(cards: [Card], cardButtonAction: @escaping CardButtonAction) {
        self.cards = cards
        self.cardButtonAction = cardButtonAction
    }
}

extension CardDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath as IndexPath) as! CardCell
        
        let index: Int = indexPath.row
        let card = cards[index]
        
        cell.configure(index: index, card: card) { index in
            self.cardButtonAction?(index)
        }
        return cell
    }
}
    
