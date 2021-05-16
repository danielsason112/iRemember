import Foundation

struct Card {
    var id: Int
    var image: String
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

extension Card {
    static var pokemonCardSet = [
        Card(id: 1, image: "1"),
        Card(id: 2, image: "4"),
        Card(id: 3, image: "6"),
        Card(id: 4, image: "7"),
        Card(id: 5, image: "10"),
        Card(id: 6, image: "13"),
        Card(id: 7, image: "18"),
        Card(id: 8, image: "19"),
        Card(id: 9, image: "23"),
        Card(id: 10, image: "25"),
        Card(id: 11, image: "35"),
        Card(id: 12, image: "37")
    ]
    
    static var flagsCardSet = [
        Card(id: 1, image: "argentina"),
        Card(id: 2, image: "france"),
        Card(id: 3, image: "greece"),
        Card(id: 4, image: "israel"),
        Card(id: 5, image: "portugal"),
        Card(id: 6, image: "singapore"),
        Card(id: 7, image: "south-korea"),
        Card(id: 8, image: "spain"),
        Card(id: 9, image: "sweden"),
        Card(id: 10, image: "united-kingdom"),
        Card(id: 11, image: "united-states-of-america"),
        Card(id: 12, image: "vietnam")
    ]
    
    static func getCards(from settings: Settings) -> [Card] {
        let count = settings.difficulty.cardsCount()
        var cards: [Card]
        switch settings.cardSet {
        case .flags:
            cards = flagsCardSet
        case .pokemon:
            cards = pokemonCardSet
        }
        return (cards[..<(count/2)] + cards[..<(count/2)]).shuffled()
    }
    
    static func getPokemonGameCards(count: Int) -> [Card] {
        return (Card.pokemonCardSet[..<(count/2)] + Card.pokemonCardSet[..<(count/2)]).shuffled()
    }
}
