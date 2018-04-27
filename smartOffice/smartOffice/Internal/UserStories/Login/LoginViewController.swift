import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    
    var manager = ServiceManager()
    var context: Context!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.text = "baglay.rodion@yandex.ru"
        passwordTextField.text = "5I4U9rdUHyUBPMxt"
        context = Context.createStorageContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

private extension LoginViewController {
    
    @IBAction func didTouchLoginButton() {

        let body = String(format: "{\"user\": {\"email\":\"%@\",\"password\":\"%@\" }}", loginTextField.text!, passwordTextField.text!)
        manager.login(parameters: body) { requestResult in
            switch requestResult {
            case .success(let userInfo):
                let identifier = TabBarViewController.storyboardIndentifier
                let storyboard = UIStoryboard(name: identifier, bundle: Bundle.main)
                let tabBarViewController = storyboard.instantiateViewController(withIdentifier: identifier) as! TabBarViewController
                tabBarViewController.token = userInfo.authorization.access_token.value
                self.present(tabBarViewController, animated: true, completion: nil)

            case .failure(let error):
                print(error)
            }
        }
    }
}

