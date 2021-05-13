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
    
    static func getPokemonGameCards(count: Int) -> [Card] {
        return (Card.pokemonCardSet[..<(count/2)] + Card.pokemonCardSet[..<(count/2)]).shuffled()
    }
}
