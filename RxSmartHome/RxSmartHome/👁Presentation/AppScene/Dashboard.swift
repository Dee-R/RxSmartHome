//  DashBoard
//  Dashboard.swift
//  Created by Eddy R on 04/02/2021.
import UIKit

class Dashboard: UITabBarController, UITabBarControllerDelegate {
    private var appDIBuilder = AppDIBuilder(appEnvironment: AppEnvironment())
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self

        // -- Devices Scene --
        // FIXME: should uses a DependencyInject
        let item1 = DevicesViewController(viewModel: DevicesViewModelImpl())
        let rootNavItemOne = UINavigationController(rootViewController: item1) // NavigationController + ViewController
        let icon1 = UITabBarItem(title: "Devices", image: UIImage(systemName: "doc.plaintext"), selectedImage: nil)
        item1.tabBarItem = icon1
//        item1.viewModel.
        // -- User Scene --
        let itemTwo = UIViewController()
        let rootNavItemTwo = UINavigationController(rootViewController: itemTwo)
        let icon2 = UITabBarItem(title: "User", image: UIImage(systemName: "person.fill"), selectedImage: nil)
        itemTwo.tabBarItem = icon2

        // -- Root tabbarViewController --
        self.viewControllers = [rootNavItemOne, rootNavItemTwo] // root of UITabBarController
        self.selectedIndex = 0

        // -- Navigation Flow --
        item1.showDeviceDetail = { element in
            debugPrint("L\(#line) 🏵 -------> ", element)
            let detailsVC = DetailsDeviceViewController()
            rootNavItemOne.pushViewController(detailsVC, animated: true)
        }
    }

    // Delegate methods
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}

class DetailsDeviceViewController: UIViewController {
    var index: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
