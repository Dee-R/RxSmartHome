//
//  Dashboard.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

import UIKit
class Dashboard : UITabBarController, UITabBarControllerDelegate {
    
    var appDIBuilder = AppDIBuilder(appEnvironment: AppEnvironment())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
        
        // -- Devices Scene --
        //        let devicesViewModel = appDIBuilder.buildDevicesWithAllDependencies()
        let item1 = DevicesViewController()
        let nav_item1 = UINavigationController(rootViewController: item1) // NavigationController + ViewController
        let icon1 = UITabBarItem(title: "Devices", image: UIImage(systemName: "doc.plaintext"), selectedImage: nil)
        item1.tabBarItem = icon1
        
        // -- User Scene --
        let item2 = UIViewController()
        item2.title = "User setting"
        let nav_item2 = UINavigationController(rootViewController: item2)
        
        let icon2 = UITabBarItem(title: "User", image: UIImage(systemName: "person.fill"), selectedImage: nil)
        item2.tabBarItem = icon2
        
        // -- Root tabbarViewController --
        self.viewControllers = [nav_item1, nav_item2] // root of UITabBarController
        self.selectedIndex = 0
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

