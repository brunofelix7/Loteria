import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var gameTypeLabel: UILabel!
    @IBOutlet weak var gameTypeControl: UISegmentedControl!
    @IBOutlet var ballsButton: [UIButton]!
    
    var game: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)
    }

    @IBAction func generateGameButton() {
        switch gameTypeControl.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
    
    func showNumbers(for type: GameType) {
        gameTypeLabel.text = type.rawValue
        
        switch type {
            case .megasena:
                generateGame(.megasena)
                ballsButton.last!.isHidden = false
            case .quina:
                generateGame(.quina)
                ballsButton.last!.isHidden = true
        }
        
        for (index, value) in game.enumerated() {
            ballsButton[index].setTitle("\(value)", for: .normal)
        }
    }
    
    func generateGame(_ type: GameType) {
        game.removeAll()
        switch type {
            case .megasena:
                while game.count < 6 {
                    let number = Int(arc4random_uniform(60) + 1)
                    if !game.contains(number) {
                        game.append(number)
                    }
                }
            case .quina:
                while game.count < 5 {
                    let number = Int(arc4random_uniform(80) + 1)
                    if !game.contains(number) {
                        game.append(number)
                    }
                }
        }
        game = game.sorted()
    }
}

