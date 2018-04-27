
import UIKit

class TimeStatisticViewController: UIViewController {
    
    static let storyboardIndentifier: String = "TimeStatisticViewController"
    private static var usersCellReuseID = "ReusableCellID"
    
    var token:String?
    var context: Context?
    var timeStatistic: TimeStatistic?
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        context?.usersManager.getUserTimeStatistic(sort: "", groupby: "", token: token!, completion: { (result) in
            switch result {
            case .success(let timeStatisticInfo):
                self.timeStatistic = timeStatisticInfo
                self.tableView.reloadData()
            case .failure(_):
                break
            }
        })
        super.viewDidLoad()
        
    }
}

// MARK :- UITableViewDataSource
extension TimeStatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeStatistic?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimeStatisticViewController.usersCellReuseID, for: indexPath) as! TimeStatisticTableViewCell
        if let statisticInfo = timeStatistic?.items[indexPath.row] {
            cell.textLabel?.text = statisticInfo.workTime
            cell.detailTextLabel?.text = statisticInfo.firstAccess
        }
        return cell
    }
    
    
}

// MARK :- UITableViewDelegate
extension TimeStatisticViewController: UITableViewDelegate {
    
}
