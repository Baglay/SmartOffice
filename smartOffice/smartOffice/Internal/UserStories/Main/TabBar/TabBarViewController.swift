
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate, Contextual {
    static let storyboardIndentifier: String = "TabBarViewController"
    var context: Context?
    var token: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        context = Context.createStorageContext()
        setupBarItems(context: context!)
    }
}

private extension TabBarViewController {
    func setupBarItems(context: Context) {
        let companyEmployeeIndentifier = CompanyEmployeeViewController.storyboardIndentifier
        let companyEmployeeStoryboard = UIStoryboard(name: companyEmployeeIndentifier, bundle: nil)
        let companyEmployeeController = companyEmployeeStoryboard.instantiateViewController(withIdentifier: companyEmployeeIndentifier) as! CompanyEmployeeViewController
        companyEmployeeController.context = context
        companyEmployeeController.token = token
        
        let timeStatisticIndentifier = TimeStatisticViewController.storyboardIndentifier
        let timeStatisticStoryboard = UIStoryboard(name: timeStatisticIndentifier, bundle: nil)
        let timeStatisticController = timeStatisticStoryboard.instantiateViewController(withIdentifier: timeStatisticIndentifier) as! TimeStatisticViewController
        timeStatisticController.context = context
        timeStatisticController.token = token
        
        let timeStatisticNavigationContoller = UINavigationController()
        timeStatisticNavigationContoller.viewControllers = [timeStatisticController]
        
        let companyEmployeeNavigationContoller = UINavigationController()
        companyEmployeeNavigationContoller.viewControllers = [companyEmployeeController]
        
        let timeStatisticBarItem = UITabBarItem(title: "Активность", image: nil, selectedImage: nil)
        let companyEmployeeBarItem = UITabBarItem(title: "Пользователи", image: nil, selectedImage: nil)
        
        timeStatisticNavigationContoller.tabBarItem = timeStatisticBarItem
        companyEmployeeNavigationContoller.tabBarItem = companyEmployeeBarItem
        
        self.viewControllers = [companyEmployeeNavigationContoller,timeStatisticNavigationContoller]
    }
}
