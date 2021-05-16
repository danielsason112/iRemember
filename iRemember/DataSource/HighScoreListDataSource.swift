import UIKit
import CoreLocation

class HighScoreListDataSource: NSObject {
    let highScoreStorageKey = "HighScores"
    
    private var highScores: [Score] = Array<Score>()
    private var storage = UserDefaultsData()
    
    override init() {
        super.init()
        let scores = storage.read(key: highScoreStorageKey, forClass: [Score].self) ?? Score.testData
        highScores = sort(scores: scores)
    }
    
    func sort(scores: [Score]) -> [Score] {
        return scores.sorted(by: {a,b in
            a.tries == b.tries ? a.time < b.time : a.tries < b.tries
        })
    }
    
    func addScore(score: Score) {
        highScores = Array(sort(scores: highScores + [score]).prefix(10))
        if !storage.store(key: highScoreStorageKey, data: highScores) {
            Score.testData = highScores
        }
    }
    
}

extension HighScoreListDataSource: UITableViewDataSource {
    static let HighscoreCellIdentifier = "HighScoreCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.HighscoreCellIdentifier, for: indexPath) as? HighScoreCellView else {
            fatalError("Unable to dequeue cell")
        }
        
        let highscore = self.highScores[indexPath.row]
            
        cell.configure(position: (indexPath.row + 1) ,name: highscore.name, moves: highscore.tries, time: highscore.time)
        
        return cell
    }
}
