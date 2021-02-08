//
//  Dashboard.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//
import UIKit
class Dashboard : UITabBarController, UITabBarControllerDelegate {
    private var appDIBuilder = AppDIBuilder(appEnvironment: AppEnvironment())
    var windowDashboard: UIWindow?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
        
        // -- Devices Scene --
        //        let devicesViewModel = appDIBuilder.buildDevicesWithAllDependencies()
        let item1 = DevicesViewController(viewModel: appDIBuilder.buildDevicesDI())
        
        let root_nav_item1 = UINavigationController(rootViewController: item1) // NavigationController + ViewController
        let icon1 = UITabBarItem(title: "Devices", image: UIImage(systemName: "doc.plaintext"), selectedImage: nil)
        item1.tabBarItem = icon1
        
        // -- User Scene --
        let item2 = UIViewController()
        item2.title = "User setting"
        let root_nav_item = UINavigationController(rootViewController: item2)
        
        let icon2 = UITabBarItem(title: "User", image: UIImage(systemName: "person.fill"), selectedImage: nil)
        item2.tabBarItem = icon2
        
        // -- Root tabbarViewController --
        self.viewControllers = [root_nav_item1, root_nav_item] // root of UITabBarController
        self.selectedIndex = 0
        
        
        // -- Navigation Flow --
        item1.showDeviceDetail = { e in
            debugPrint("L\(#line) 🏵 -------> ", e)
            let detailsVC = DetailsDeviceViewController()
            root_nav_item1.pushViewController(detailsVC, animated: true)
        }
    }
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

class DetailsDeviceViewController: UIViewController {
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    // TODO: select the right device to set 
}

