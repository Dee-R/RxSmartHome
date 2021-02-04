//  VIEW
//  DevicesViewController.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class DevicesViewController: UIViewController {
    // MARK: - PROPERTIES
    var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        setting()
    }
}


// MARK: - UI
extension DevicesViewController {
    fileprivate func buildUI() {
        buildMainView()
    }
    fileprivate func buildMainView() {
        // -- mainView --
        let mainView = UIView(frame: .zero)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        mainView.backgroundColor = .brown
        self.mainView = mainView
    }
}

// MARK: - Setting
extension DevicesViewController {
    fileprivate func setting() {
        setColorMainView()
        setTitleNavigationController()
        setLargeTitleNavigationController()
    }
    fileprivate func setColorMainView() {
        self.view.backgroundColor = .white
    }
    fileprivate func setTitleNavigationController() {
        self.title = "Devices"
    }
    fileprivate func setLargeTitleNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
