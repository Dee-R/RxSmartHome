/// VIEW
//  DevicesViewController.swift
//  Created by Eddy R on 04/02/2021.
import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class DevicesViewController: UIViewController {
    // MARK: - PROPERTIES
    var viewModel: DeviceViewModel
    
    private var mainView: UIView!
    private let bag = DisposeBag()
    private var filtersCV: UICollectionView! //Filter
    private var devicesCV: UICollectionView!//Device
    private var filtersLayout: UICollectionViewFlowLayout!
    private var devicesLayout: UICollectionViewFlowLayout!
    private let cellPerRowForDevicesCollectionView: Int = 2 // ---- Setting Devices CollectionView ----
    private let isRatioForDevicesCollectionView = false // ---- Setting Devices CollectionView ----
    var showDeviceDetail: (IndexPath)->() = { _ in } /// flow rooter
    
    init(viewModel: DeviceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        setting()
        bindindRx()
        
        viewModel.showDevices()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // //!\ ◼︎◼︎◼︎ Important ◼︎◼︎◼︎ /!\\
        // get the Real Size of the collection view
        // resize the cell in the layout to match with the max height from collection View
        // settled with auto layout
        
        // -- DevicesCollectionViewCell : Defines Size Cell (Filters & Devices) --
        setSizeCellforDevicesCollectionView()
        setSizeCellforFiltersCollectionView()
    }
    
    private func bindindRx() {
        loadViewIfNeeded()

        viewModel.dataFilter.bind(to: filtersCV.rx.items(cellIdentifier: FiltersCVCell.reuseID, cellType: FiltersCVCell.self)) { index,value,cell in
            cell.filterLabel.text = "\(value)"
            
        }.disposed(by: bag) // -- filters --
        viewModel.dataDevices.bind(to: devicesCV.rx.items(cellIdentifier: DevicesCVCell.reuseID, cellType: DevicesCVCell.self)) { index,value,cell in
            cell.deviceTitle.text = "\(value)"
        }.disposed(by: bag) // -- devices --
        filtersCV.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] indexPathValue in
            guard let this = self else {return}
            
            try? this.filterDevices("toto") // pass the type:Any
            
        }).disposed(by: bag)
        devicesCV.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
            guard let this = self else {return}
            
            
            let index = indexPath
            this.showDeviceDetail(index)
            // ne pas pousser directement le view controller directement depuis le call back
        }).disposed(by: bag)
    }
    
    private func filterDevices(_ typeDevices: String) throws -> Void  {
        print("░░░██❄️ -- FilterDevices  ❄️██░░░ [ \(type(of: self)) L\(#line)")
        let typeD = typeDevices
        guard let devices = try? viewModel.dataDevices.value() else {return}
        print(devices)
        let newArray = devices.filter { (value) -> Bool in
            return typeD == value
        }
        viewModel.dataDevices.onNext(newArray)
        // in : recois le type du bouton
        // other : array des devices
        /**
         boucler sur tous les devices
         si devices ne match pas avec in
            alors
                soit je cache la cellule, mais la data sera toujours là dans l'array
                soit je set un Boolen qui lorsque tableview ecoutera la radio(obserble) il regenera le rendu
         
         */
    }
}

extension DevicesViewController {
    private func buildUI() {
        buildMainView()
        buildFiltersCV()
        buildDevicesCV()
    }
    private func buildMainView() {
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
    private func buildFiltersCV() {
        // -- Build Layout --
        filtersLayout = UICollectionViewFlowLayout()
        filtersLayout.scrollDirection = .horizontal
        filtersLayout.itemSize.width = self.view.frame.width / 3
        
        // -- Build CollectionView --
        filtersCV = UICollectionView(frame: .zero, collectionViewLayout: filtersLayout)
        filtersCV.backgroundColor = UIColor.white
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
    }
    private func buildDevicesCV() {
        // -- Build Layout --
        devicesLayout = UICollectionViewFlowLayout()
        devicesLayout.scrollDirection = .vertical
        devicesLayout.itemSize = CGSize(width: 50, height: 50)
        
        // -- Build CollectionView --
        devicesCV = UICollectionView(frame: .zero, collectionViewLayout: devicesLayout)
        devicesCV.backgroundColor = .white
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
    }
} // UI
extension DevicesViewController {
    private func setting() {
        setColorMainView()
        setTitleNavigationController()
        setLargeTitleNavigationController()
    }
    private func setColorMainView() {
        self.view.backgroundColor = .white
    }
    private func setTitleNavigationController() {
        self.title = "Devices"
    }
    private func setLargeTitleNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setSizeCellforDevicesCollectionView() {
        let marginDevices = self.mainView.frame.size.width / CGFloat(cellPerRowForDevicesCollectionView) * 0.10
        devicesLayout.sectionInset = UIEdgeInsets(top: marginDevices, left: marginDevices, bottom: marginDevices, right: marginDevices)
        let gap = marginDevices
        devicesLayout.minimumInteritemSpacing = gap
        devicesLayout.minimumLineSpacing = marginDevices
        let sizePerItem = (mainView.frame.size.width / CGFloat(cellPerRowForDevicesCollectionView))
        let sizeAjusted = sizePerItem - marginDevices - (gap / CGFloat(cellPerRowForDevicesCollectionView))
        let sizeRounded = CGFloat(round(100*sizeAjusted) / 100)
        
        devicesLayout.itemSize.width = sizeRounded
        devicesLayout.itemSize.height = isRatioForDevicesCollectionView ? sizeRounded : sizeRounded / 1.5
    }
    private func setSizeCellforFiltersCollectionView() {
        let marginFilters = self.mainView.frame.size.width / CGFloat(cellPerRowForDevicesCollectionView) * 0.10
        filtersLayout.sectionInset = UIEdgeInsets(top: marginFilters, left: marginFilters, bottom: marginFilters, right: marginFilters)
        filtersLayout.itemSize.height = filtersCV.bounds.height - marginFilters * 2
    }
} // Setting
