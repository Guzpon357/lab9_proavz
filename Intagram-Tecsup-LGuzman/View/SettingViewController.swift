
import UIKit

class SettingViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    let options: [String] = [
            "Archive",
            "Your active",
            "Nametag",
            "Saved",
            "Close friends",
            "Discover people",
            "Open facebook"
        ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func onTabBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for :indexPath)
        var contentListConfig = UIListContentConfiguration.cell()
        contentListConfig.text = options[indexPath.row]
        contentListConfig.image = UIImage(systemName: "person")
        cell.contentConfiguration = contentListConfig
        return cell
    }
}
