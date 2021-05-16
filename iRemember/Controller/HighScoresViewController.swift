import UIKit
import MapKit

class HighScoresViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var map: MKMapView!
    @IBOutlet var waitingView: WaitingForLocationView!
    
    private var highScoreListDataSource: HighScoreListDataSource?
    private let locationManager = CLLocationManager()
    private var newScore: Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreListDataSource = HighScoreListDataSource()
        tableView.dataSource = highScoreListDataSource
        
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed(_:)))
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        if
            locationManager.authorizationStatus == .authorizedWhenInUse ||
                locationManager.authorizationStatus ==  .authorizedAlways
        {
            locationManager.requestLocation()
        }
    }
    
    func configure(score: Score) {
        self.newScore = score
    }
    
    @objc func backPressed(_ sender: Any){
         self.navigationController?.popToRootViewController(animated: true)
    }
}

extension HighScoresViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[locations.count - 1]
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        if var score = newScore {
            score.latitude = currentLocation.coordinate.latitude
            score.longitude = currentLocation.coordinate.longitude
            self.highScoreListDataSource?.addScore(score: score)
            self.tableView.reloadData()
        }
        
        map.setRegion(MKCoordinateRegion(center: currentLocation.coordinate, span: span), animated: true)
        
        let scores = Score.testData
        for score in scores {
                let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: score.latitude, longitude: score.longitude)
                marker.title = score.name
                map.addAnnotation(marker)
        }
        
        self.waitingView.isHidden = true
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
        if let score = newScore {
            self.highScoreListDataSource?.addScore(score: score)
            self.tableView.reloadData()
        }
        
        self.waitingView.isHidden = true
    }
}
