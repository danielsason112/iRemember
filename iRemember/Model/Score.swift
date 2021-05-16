import Foundation
import CoreLocation

struct Score: Codable {
    var name: String
    var tries: Int
    var time: Int
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}

extension Score {
    static var testData = [
        Score(name: "Daniel", tries: 18, time: 58, latitude: 32.1136168654841, longitude: 34.8181239),
        Score(name: "John Doe", tries: 18, time: 63, latitude: 32.1134975939709, longitude: 34.80364142922397),
        Score(name: "Luke Skywalker", tries: 20, time: 56, latitude: 32.10682981374053, longitude: 34.81191033433368),
        Score(name: "frodo baggins", tries: 21, time: 68, latitude: 32.10982981374053, longitude: 34.82191033433368),
        Score(name: "Forest Gump", tries: 23, time: 75, latitude: 32.11482981374053, longitude: 34.81691033433368),
        Score(name: "Pitter Parker", tries: 24, time: 71, latitude: 32.10482981374053, longitude: 34.81991033433368),
        Score(name: "Clark Kent", tries: 24, time: 78, latitude: 32.10752981374053, longitude: 34.81841033433368),
        Score(name: "Bob Marley", tries: 26, time: 85, latitude: 32.10822981374053, longitude: 34.83891033433368)
    ]
}
