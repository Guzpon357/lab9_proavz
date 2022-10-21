
import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func onTabBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
