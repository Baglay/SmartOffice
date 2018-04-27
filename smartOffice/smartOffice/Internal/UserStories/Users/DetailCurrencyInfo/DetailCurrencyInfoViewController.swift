
import UIKit

class DetailCurrencyInfoViewController: UIViewController {
    static let storyboardIndentifier: String = "DetailCurrencyInfoViewController"
    
    var userDetail: (user: User, index: Int)?
    var context: Context?
    var token: String?
    @IBOutlet private weak var info: UILabel!
    
    override func viewDidLoad() {
       //  context = Context.createStorageContext()
        guard let user = userDetail?.user, let index = userDetail?.index, let token = token else {
            return
        }
        context?.usersManager.getUserAccountInfo(uid: user.uid, aid: String(user.accounts[index].id), token: token, completion: { (result) in
            switch result {
            case .success(let info):
                self.info.text = " Кошелек \(info.currency)  баланс \(info.balance)"
            case .failure(let error):
                break
            }
        })
        super.viewDidLoad()
    }
}
