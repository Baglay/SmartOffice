
import UIKit

class CompanyEmployeeViewController: UIViewController {
    static let storyboardIndentifier: String = "CompanyEmployeeViewController"
    private static var usersCellReuseID = "ReusableCellID"
    var token:String?
    var context: Context?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // context = Context.createStorageContext()
       // setupNavigationBar()
        activityIndicator.startAnimating()
        context?.usersManager.getAllUsers(token: token!, completion: { (requestResult) in
            self.reloadUI(value: requestResult)
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // to fix iOS 11.2 bug, when button remains faded after segue back
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = true
        //
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension CompanyEmployeeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context?.usersManager.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyEmployeeViewController.usersCellReuseID, for: indexPath) as! UserTableViewCell
        if let user = context?.usersManager.users[indexPath.row] {
            let url = URL(string: user.image)
            let data = try! Data(contentsOf: url!)
            cell.avatarImage?.image = UIImage(data: data)
            cell.nameLabel?.text = user.name
            cell.emailLabel?.text = user.email
        }
        return cell
    }
}
// MARK: - UITableViewDelegate
extension CompanyEmployeeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let uid = context?.usersManager.users[indexPath.row].uid
//        let aid = context?.usersManager.users[indexPath.row].accounts[indexPath.row].id
        let identifier = DetailUserViewController.storyboardIndentifier
        let storyboard = UIStoryboard(name: identifier, bundle: Bundle.main)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailUserViewController
        detailViewController.token = token
        detailViewController.context = context
        guard let user = context?.usersManager.users[indexPath.row] else {
            return
        }
        detailViewController.userDetail = (user: user, indexPath.row)
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

extension CompanyEmployeeViewController {
    
    func showError(error: Error){
        let errorAllert = UIAlertController(title: NSLocalizedString("record.main.alertController.title", comment: ""), message: NSLocalizedString("record.main.alertController.message", comment: "") + " \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("record.main.alertAction.ok.title", comment: ""), style: .cancel, handler: nil)
        errorAllert.addAction(okAction)
        present(errorAllert, animated: true, completion: nil)
    }
    
    
    func reloadUI(value: UserResult<[User]>, indexPath: IndexPath? = nil) {
        activityIndicator.stopAnimating()
        switch value {
        case .success(_):
            tableView.reloadData()
        case .failure(let error):
            showError(error: error.message as! Error)
        }
    }
}


private extension CompanyEmployeeViewController {
   
    private func setupNavigationBar() {
        let preferencesButton = UIBarButtonItem(title: "123", style: .plain, target: nil, action: nil)
      
        
        navigationItem.leftBarButtonItem = preferencesButton
       // navigationItem.rightBarButtonItem = addCurrencyButton
    }
}
