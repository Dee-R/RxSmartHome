//import UIKit
//import RxSwift
//import RxCocoa
//import RxBlocking
//import PlaygroundSupport
//
//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .gray
//        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 600)) // default setting
//        self.view = view
//    }
//    
//    // MARK: - Properties
//    var viewModel = ViewModel()
//    var collection1: UICollectionView!
//    var collection2: UICollectionView!
//    
//    var deviceFiltered = BehaviorSubject<[Device]>(value: []) //output
//    var bag = DisposeBag() // bag
//    
//    
//    // MARK: - Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewModel.fetchDevices()
//        
//        let devices = viewModel.devices
//        deviceFiltered = devices
//        
//        // -- Build UI --
//        collectionView1()
//        collectionView2()
//        
//        binding()
//        
//    }
//    func collectionView1() {
//        // -- Make Layout --
//        let layout1 = UICollectionViewFlowLayout()
//        layout1.estimatedItemSize = .zero
//        layout1.itemSize = CGSize(width: 100, height: view.frame.size.height * 0.10)
//        layout1.scrollDirection = .horizontal
//        layout1.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        
//        // -- Make Collection View --
//        let frame1 = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height * 0.10)
//        self.collection1 = UICollectionView(frame: frame1, collectionViewLayout: layout1)
//        collection1.backgroundColor = UIColor.darkGray
//        view.addSubview(collection1)
//        
//        // -- Bind it --
//        collection1.register(Cell1.self, forCellWithReuseIdentifier: Cell1.reuseID)
//        
//        
//        viewModel.filters.bind(to: collection1.rx.items(cellIdentifier: Cell1.reuseID, cellType: Cell1.self)) { indexPath, value, cell in
//            cell.layer.cornerRadius = 10 // set radius item
//            cell.layer.masksToBounds = true
//            cell.layer.borderWidth = 3
//            cell.layer.borderColor = UIColor.red.cgColor
//            cell.titleLabel.text = value.name
//        }
//        .disposed(by: bag)
//        
//        /**
//         ListFilter.bind(to: collection1.rx.items(cellIdentifier: Cell1.reuseID, cellType: Cell1.self)) { indexPath, value, cell in
//         cell.layer.cornerRadius = 10 // set radius item
//         cell.layer.masksToBounds = true
//         cell.layer.borderWidth = 3
//         cell.layer.borderColor = UIColor.red.cgColor
//         cell.titleLabel.text = value
//         }
//         .disposed(by: bag)
//         */
//    }
//    func collectionView2() {
//        // -- Make Layout --
//        let layout2 = UICollectionViewFlowLayout()
//        layout2.itemSize = CGSize(width: 100, height: view.frame.size.height * 0.10)
//        let devicesFrame = CGRect(x: 0, y: view.frame.size.height * 0.11, width: view.frame.size.width, height: view.frame.size.height * 0.88)
//        self.collection2 = UICollectionView(frame: devicesFrame, collectionViewLayout: layout2)
//        collection2.backgroundColor = UIColor.brown
//        view.addSubview(collection2)
//        
//        // -- Bind it --
//        collection2.register(Cell2.self, forCellWithReuseIdentifier: Cell2.reuseID)
//        deviceFiltered.bind(to: collection2.rx.items(cellIdentifier: Cell2.reuseID, cellType: Cell2.self)) { indexpath, value, cell in
//            cell.contentView.backgroundColor = .red
//            cell.titleLabel.textColor = .red
//            cell.titleLabel.text = value.deviceName
//        }
//        .disposed(by: bag)
//        
//    }
//    func binding() {
//        // -- Arr FilterCV to Arr DevicesCV --
//        Observable.combineLatest(collection1.rx.itemSelected, deviceFiltered, viewModel.filters) { [weak self] (itemSelected, arrDevices, filtersArr) in
//            guard let this = self else {return}
//            var value = try this.viewModel.filters.value()
//            /*
//             si filter 1 == true
//             alors afficher seulement prototype type
//             
//             */
//            
//            value.filter { (filter) -> Bool in
//                return filter.isActivate == true
//            }.map { (filter)  in
//                
//            }
//        }
//        .subscribe()
//        .disposed(by: bag)
//        
//        
//        //        Observable.combineLatest(collection1.rx.itemSelected, listDataDevice) { (tap, dataArrString) in
//        //            // |-- Lights --- RollersShutter ---  Lights --- Heaters --|->
//        //            dataArrString.filter { (row) -> Bool  in
//        //                if row == "Lights" {
//        //                    return true
//        //                }
//        //                return false
//        //            }
//        //        }
//        //        .map({ (arrString) -> [Filter] in
//        //            let arrOfFilter = arrString.map { (element) -> Filter in
//        //                return Filter(type: "element")
//        //            }
//        //            return arrOfFilter
//        //        })
//        //        .bind(to: listFiltered)
//        //        .disposed(by: bag)
//        
//    }
//}
//
//
//// MARK: - Custom Class
//// FilterCell class
//class Cell1: UICollectionViewCell {
//    static let reuseID = "Cell1"
//    fileprivate var titleLabel: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.numberOfLines = 0
//        l.baselineAdjustment = .alignCenters
//        l.contentMode = .topLeft
//        l.text = "_"
//        l.backgroundColor = .yellow
//        l.textAlignment = .center
//        return l
//    }()
//    override init(frame: CGRect) { // code
//        super.init(frame: frame)
//        backgroundColor = .white
//        contentView.addSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        setNeedsLayout()  // cell needs to be laid out
//        layoutIfNeeded() //  to position the content view’s subviews according to the constraints defined
//        let option0 = layoutAttributes.size
//        let _ = UIView.layoutFittingExpandedSize
//        let _ = UIView.layoutFittingCompressedSize
//        let size = contentView.systemLayoutSizeFitting(option0) // determine the optimum size for the cell
//        
//        var newframe = layoutAttributes.frame
//        
//        newframe.size = size
//        layoutAttributes.frame = newframe
//        return layoutAttributes
//    }
//    required init?(coder: NSCoder) { // SB
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//class Cell2: UICollectionViewCell {
//    static let reuseID = "FilterCollectionViewCell"
//    fileprivate var titleLabel: UILabel = {
//        let l = UILabel()
//        l.translatesAutoresizingMaskIntoConstraints = false
//        l.numberOfLines = 0
//        l.baselineAdjustment = .alignCenters
//        l.contentMode = .topLeft
//        l.textColor = .red
//        l.tintColor = .red
//        l.text = "_"
//        l.backgroundColor = .white
//        l.textAlignment = .center
//        return l
//    }()
//    override init(frame: CGRect) { // code
//        super.init(frame: frame)
//        backgroundColor = .white
//        contentView.addSubview(titleLabel)
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        setNeedsLayout()  // cell needs to be laid out
//        layoutIfNeeded() //  to position the content view’s subviews according to the constraints defined
//        let option0 = layoutAttributes.size
//        let _ = UIView.layoutFittingExpandedSize
//        let _ = UIView.layoutFittingCompressedSize
//        let size = contentView.systemLayoutSizeFitting(option0) // determine the optimum size for the cell
//        
//        var newframe = layoutAttributes.frame
//        
//        newframe.size = size
//        layoutAttributes.frame = newframe
//        return layoutAttributes
//    }
//    required init?(coder: NSCoder) { // SB
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()
//
//
//
//
//
//
//class ViewModel {
//    fileprivate var filters = BehaviorSubject<[Filter]>(value: [])
//    fileprivate var devices = BehaviorSubject<[Device]>(value: [])
//    
//    func fetchDevices() {
//        Api.fetchDevice { [weak self] (devices) in
//            guard let this = self else {return}
//            //this.devices = devices // set array devices
//            this.devices.onNext(devices)
//            
//            
//            var arrayFilter: [String] = [] // set array filter
//            devices.forEach { (rowObj) in
//                if !(arrayFilter.contains(rowObj.productType.rawValue)) {
//                    arrayFilter.append(rowObj.productType.rawValue)
//                }
//            }
//            let arrFilter: [Filter] = arrayFilter.map { (rowString) -> Filter in
//                Filter(name: rowString)
//            }
//            
//            this.filters.onNext(arrFilter)
//        }
//    }
//}
//
//class Api {
//    static func fetchDevice(completion: ([Device]) -> Void ) {
//        let devices: [Device] = [
//            Device(id: UUID(), productType: .light, deviceName: "room - light", mode: "On", intensity: 50, position: nil, temperature: nil),
//            Device(id: UUID(), productType: .heater, deviceName: "room - heater", mode: "On", intensity: nil, position: nil, temperature: 27),
//            Device(id: UUID(), productType: .rollerShutter, deviceName: "room - rollerShutter", mode: nil, intensity: nil, position: 70, temperature: nil),
//            Device(id: UUID(), productType: .rollerShutter, deviceName: "room - rollerShutter", mode: nil, intensity: nil, position: 70, temperature: nil)
//        ]
//        // get data
//        // send it back
//        completion(devices) // je donne les data
//    }
//}
//
//enum ProductType: String {
//    case light = "Light"
//    case rollerShutter = "Roller Shutter"
//    case heater = "Heater"
//}
//
//struct Device {
//    var id: UUID
//    var productType: ProductType
//    var deviceName: String
//    var mode: String?
//    var intensity: Int?
//    var position: Int?
//    var temperature: Float?
//}
//
//struct Filter {
//    var name: String
//    var isActivate: Bool = false
//}
//
