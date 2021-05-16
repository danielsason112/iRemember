import UIKit

class SettingsViewController: UIViewController {
    
    private var settings = Settings.defaultSettings
    
    @IBOutlet var difficultyHintLabel: UILabel!
    @IBOutlet var difficultySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(difficulty: settings.difficulty)
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveSettings))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    func saveSettings() {
        let difficulty = Difficulty.fromCardsCount(cardsCount: Int(difficultySlider.value)) ?? settings.difficulty
        let newSetting = Settings(difficulty: difficulty)
        Settings.update(newSettings: newSetting)
        navigationController?.popViewController(animated: true)
    }
    
    func updateView(difficulty: Difficulty) {
        difficultySlider.value = Float(difficulty.cardsCount())
        difficultyHintLabel.text = difficulty.hintText()
    }
    
    @IBAction func onSliderChange(sender: UISlider) {
        let rounded = round(sender.value / 4) * 4
        if let difficulty = Difficulty.fromCardsCount(cardsCount: Int(rounded)) {
            updateView(difficulty: difficulty)
        }
    }
}
