import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameModeChange: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ViewController2
        dest.mode = gameModeChange.selectedSegmentIndex
    }


}

