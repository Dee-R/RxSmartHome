//  VIEW
//  DevicesViewController.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
import UIKit
import RxSwift
import RxCocoa
import RxBlocking



class DevicesViewController: UIViewController {
    // MARK: - PROPERTIES
    var viewModel: DevicesViewModel
    
    private var mainView: UIView!
    private let bag = DisposeBag()
    var filtersCV: UICollectionView! //Filter
    var filtersLayout: UICollectionViewFlowLayout!
    var devicesCV: UICollectionView!//Device
    var devicesLayout: UICollectionViewFlowLayout!
//    let fakeDataFilters = BehaviorSubject<[Int]>(value: Array(0...5))// FakeDataFilter
    let fakeDataDevices = BehaviorSubject<[Int]>(value: Array(0...10))// FakeDataFilter
    private let cellPerRowForDevicesCollectionView: Int = 2 // ---- Setting Devices CollectionView ----
    private let isRatioForDevicesCollectionView = false // ---- Setting Devices CollectionView ----
    
    init(viewModel: DevicesViewModel) {
        self.viewModel = DevicesViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        buildUI()
        setting()
        bindindRx()
        
        viewModel.showDevices()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // //!\ ◼︎◼︎◼︎ Important ◼︎◼︎◼︎ /!\\
        // get the Real Size of the collection view
        // resize the cell in the layout to match with the max height from collection View
        // settled with auto layout
        
        // -- DevicesCollectionViewCell : Defines Size Cell (Filters & Devices) --
        setSizeCellforDevicesCollectionView()
        setSizeCellforFiltersCollectionView()
    }
    
    let detailVC1 = UIViewController()
    
    fileprivate func bindindRx() {
        loadViewIfNeeded()
        // -- filters --
        viewModel.dataFilter.bind(to: filtersCV.rx.items(cellIdentifier: FiltersCVCell.reuseID, cellType: FiltersCVCell.self)) { index,value,cell in
            cell.filterButton.setTitle("\(value)", for: UIControl.State.normal)
        }.disposed(by: bag)
        
        // -- devices --
        viewModel.dataDevices.bind(to: devicesCV.rx.items(cellIdentifier: DevicesCVCell.reuseID, cellType: DevicesCVCell.self)) { index,value,cell in
            cell.deviceTitle.text = "\(value)"
        }.disposed(by: bag)
        
            
        devicesCV.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] e in
            // ne pas pousser directement le view controller directement depuis le call back
        }).disposed(by: bag)
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
    fileprivate func buildDevicesCV() {
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
    fileprivate func setSizeCellforDevicesCollectionView() {
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
    fileprivate func setSizeCellforFiltersCollectionView() {
        let marginFilters = self.mainView.frame.size.width / CGFloat(cellPerRowForDevicesCollectionView) * 0.10
        filtersLayout.sectionInset = UIEdgeInsets(top: marginFilters, left: marginFilters, bottom: marginFilters, right: marginFilters)
        filtersLayout.itemSize.height = filtersCV.bounds.height - marginFilters * 2
    }
}
extension DevicesViewController {
    enum DevicesLogic {
//        static func chooseDevices(trigger: Observable<IndexPath>, devicesData: Observable<Data>) -> Observable<Devices> {
//        }
    }
}
struct Devices {
    var type: String
}



// MARK: - VIEWMODEL
// output
protocol DevicesViewModelOutput {
    var dataFilter: BehaviorSubject<[Int]> {get set}
    var dataDevices: BehaviorSubject<[Int]> {get set}
}
protocol DevicesViewModelInput {
    func showDevices()
}
class DevicesViewModel: DevicesViewModelOutput, DevicesViewModelInput  {
    var interactor: InteractorInterface
    internal var dataFilter = BehaviorSubject<[Int]>(value: []) //    fileprivate var dataDevices = BehaviorSubject<[Int]>(value: Array(0...10))
    internal var dataDevices = BehaviorSubject<[Int]>(value: [])
    
    init() {
        self.interactor = InteractorDevices()
    }
    
    func showDevices() {
        // demande interactor
        interactor.getDevices { (devicesArr) in
            
//            dataFilter.value().append(contentsOf: devicesArr)
            
        }
    }
}

// ⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬⌬
protocol InteractorInterface { // IWANT someone who
    func getDevices(completion:([Int])->())
}

class InteractorDevices: InteractorInterface { // I GOT SOMEONE WHO
    func getDevices(completion: ([Int])->()) {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        // get data form repo
        let dataFilter = Array(1...10)
        // send them
        completion(dataFilter)
    }
}
