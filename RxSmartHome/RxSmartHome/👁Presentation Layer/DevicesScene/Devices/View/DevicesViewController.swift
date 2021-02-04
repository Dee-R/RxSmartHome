//  VIEW
//  DevicesViewController.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

// ❔ Quoi   - 🗺 Ou   - ⏳Quand - ✋Comment
// 🤸🏽 Action - 🗺 Lieu - ⏳Temps - ✋Maniere

import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class DevicesViewController: UIViewController {
    // MARK: - PROPERTIES
    private var mainView: UIView!
    private let bag = DisposeBag()
    var filtersCV: UICollectionView! //Filter
    var filtersLayout: UICollectionViewFlowLayout!
    var devicesCV: UICollectionView!//Device
    var devicesLayout: UICollectionViewFlowLayout!
    let fakeDataFilters = BehaviorSubject<[Int]>(value: Array(0...5))// FakeDataFilter
    let fakeDataDevices = BehaviorSubject<[Int]>(value: Array(0...5))// FakeDataFilter
    
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
        buildFiltersCV()
        buildDevicesCV()
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
        
        mainView.backgroundColor = .rgb(red: 240, green: 230, blue: 240)
        self.mainView = mainView
    }
    fileprivate func buildFiltersCV() {
        // -- Build Layout --
        filtersLayout = UICollectionViewFlowLayout()
        filtersLayout.scrollDirection = .horizontal
        filtersLayout.itemSize.width = self.view.frame.width / 3
        
        // -- Build CollectionView --
        filtersCV = UICollectionView(frame: .zero, collectionViewLayout: filtersLayout)
        filtersCV.backgroundColor = UIColor.gray1
        filtersCV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(filtersCV)
        
        // -- Set Constraint --
        NSLayoutConstraint.activate([
            filtersCV.topAnchor.constraint(equalTo: mainView.topAnchor),
            filtersCV.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            filtersCV.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            filtersCV.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.10)
        ])
        
        // -- Register Cell --
        filtersCV.register(FiltersCVCell.self, forCellWithReuseIdentifier: FiltersCVCell.reuseID)
        
        // -- Binding --
        // FIXME: bind with viewmodel
        fakeDataFilters.bind(to: filtersCV.rx.items(cellIdentifier: FiltersCVCell.reuseID, cellType: FiltersCVCell.self)) { index,value,cell in
            cell.filterButton.setTitle("\(value)", for: UIControl.State.normal)
        }.disposed(by: bag)
    }
    fileprivate func buildDevicesCV() {
        // -- Build Layout --
        devicesLayout = UICollectionViewFlowLayout()
        devicesLayout.scrollDirection = .vertical
        devicesLayout.itemSize = CGSize(width: 50, height: 50)
        
        // -- Build CollectionView --
        devicesCV = UICollectionView(frame: .zero, collectionViewLayout: devicesLayout)
        devicesCV.backgroundColor = .green
        devicesCV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(devicesCV)
        
        // -- Set Constraint --
        NSLayoutConstraint.activate([
            devicesCV.topAnchor.constraint(equalTo: filtersCV.bottomAnchor),
            devicesCV.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            devicesCV.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            devicesCV.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
        // -- Register Cell --
        devicesCV.register(DevicesCVCell.self, forCellWithReuseIdentifier: DevicesCVCell.reuseID)
        
        // -- Binding --
        fakeDataDevices.bind(to: devicesCV.rx.items(cellIdentifier: DevicesCVCell.reuseID, cellType: DevicesCVCell.self)) { index,value,cell in
            cell.devicesButton.setTitle("\(value)", for: UIControl.State.normal)
        }.disposed(by: bag)
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
