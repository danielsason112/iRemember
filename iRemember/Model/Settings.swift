import Foundation

struct Settings {
    var difficulty: Difficulty
}

enum Difficulty: Int, CaseIterable {
    case easy
    case normal
    case hard
    
    func cardsCount() -> Int {
        switch self {
        case .easy:
            return 16
        case .normal:
            return 20
        case .hard:
            return 24
        }
    }
    
    func hintText() -> String {
        switch self {
        case .easy:
            return "(Easy - 16 cards)"
        case .normal:
            return "(Normal - 20 cards)"
        case .hard:
            return "(Hard - 24 cards)"
        }
    }
    
    static func fromCardsCount(cardsCount: Int) -> Difficulty? {
        switch cardsCount {
        case 16:
            return .easy
        case 20:
            return .normal
        case 24:
            return .hard
        default:
            return nil
        }
    }
}

extension Settings {
    static var defaultSettings = Settings(difficulty: .easy)
    
    static func update(newSettings: Settings) {
        Self.defaultSettings = newSettings
    }
}
