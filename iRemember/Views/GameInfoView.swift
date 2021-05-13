import UIKit

class GameInfoView: UIStackView {
    @IBOutlet var triesLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    func configure(tries: Int, timer: Int) {
        triesLabel.text = "Moves: \(tries)"
        timerLabel.text = "Time: \(timer / 60):\(timer % 60 > 9 ? "" : "0")\(timer % 60)"
    }
}
