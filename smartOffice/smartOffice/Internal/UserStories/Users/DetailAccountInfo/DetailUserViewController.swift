

import UIKit

class DetailUserViewController: UIViewController {
    
    static let storyboardIndentifier: String = "DetailUserViewController"
    private static var usersCellReuseID = "ReusableCellID"
    @IBOutlet private weak var uidLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var roleLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    
    var token:String?
    var context: Context?
    var userDetail: (user: User, index: Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Пользователи"
        guard let user = userDetail?.user else {
            return
        }
        uidLabel?.text = "\(user.uid)"
        nameLabel?.text = "\(user.name)"
        roleLabel?.text = "\(user.role)"
        emailLabel?.text = "\(user.email)"
        let image = user.image
        let  url = URL(string: image)
        let data = try! Data(contentsOf: url!)
        avatarImage.image = UIImage(data: data)
    }
}

// MARK: - UITableViewDataSource
extension DetailUserViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetail?.user.accounts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailUserViewController.usersCellReuseID, for: indexPath) as! DetailTableViewCell
        guard let user = userDetail?.user, let index = userDetail?.index else {
            return cell
        }
        context?.usersManager.getUserAccountInfo(uid: user.uid, aid: String(user.accounts[indexPath.row].id), token: self.token!, completion: { (result) in
            switch result {
            case .success(let userInfo):
                cell.textLabel?.text = userInfo.currency
            case .failure(let error):
                break
            }
        })
        if let user = userDetail?.user.accounts[indexPath.row] {
            cell.textLabel?.text = "id = \(user.id)"
            cell.detailTextLabel?.text = "balance \(user.balance)"
        }
        return cell
    }
}
// MARK: - UITableViewDelegate
extension DetailUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let identifier = DetailCurrencyInfoViewController.storyboardIndentifier
        let storyboard = UIStoryboard(name: identifier, bundle: Bundle.main)
        let detailCurrencyInfoViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailCurrencyInfoViewController
        guard let userDetail = userDetail  else {
            return
        }
        detailCurrencyInfoViewController.userDetail = (user: userDetail.user, index: indexPath.row)
        detailCurrencyInfoViewController.token = token
        detailCurrencyInfoViewController.context = context
        self.navigationController?.pushViewController(detailCurrencyInfoViewController, animated: true)
        self.navigationController?.navigationBar.isHidden = true
        
    }
}
