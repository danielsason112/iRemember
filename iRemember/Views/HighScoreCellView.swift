import UIKit

class HighScoreCellView: UITableViewCell {
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var movesLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    func configure(position: Int, name: String, moves: Int, time: Int) {
        positionLabel.text = "\(position). "
        nameLabel.text = name
        movesLabel.text = "\(moves)"
        timeLabel.text = "\(time / 60):\(time % 60 > 9 ? "" : "0")\(time % 60)"
    }
}
