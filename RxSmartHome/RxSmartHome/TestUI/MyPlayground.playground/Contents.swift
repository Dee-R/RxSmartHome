import UIKit
 import RxSwift
 import RxCocoa
 import RxBlocking
 import PlaygroundSupport
// 300 - 600
 class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 600)) // default setting
        self.view = view
    }
    // MARK: - Properties
    var mainView: UIView!
    var filterlayout: UICollectionViewFlowLayout!
    var filterCollectionView: UICollectionView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
		buildUI()
    }

    // ui
    func buildUI() {
		buildMainView()
        buildFilterLayout()
    }
    func buildMainView() {
        let mainView = UIView(frame: .zero)
        mainView.backgroundColor = .orange
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        mainView.backgroundColor = .orange
        self.view = mainView
    }
    func buildFilterLayout() {
		// build Layout
        filterlayout = UICollectionViewFlowLayout()
        filterlayout.scrollDirection = .horizontal
        filterlayout.itemSize.width = self.view.frame.width / 3

        // build collectionView
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterlayout)
        filterCollectionView.backgroundColor = UIColor.brown
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(filterCollectionView)

        // set constraint
        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: mainView.topAnchor),
            filterCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            filterCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            filterCollectionView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.10)
        ])
    }


 }
 PlaygroundPage.current.liveView = MyViewController()

extension UIColor {
    static let gray1 = UIColor.rgb(240, 240, 240)
    static let gray2 = UIColor.rgb(224, 224, 224)
    static let gray3 = UIColor.rgb(208, 208, 208)
    static let gray4 = UIColor.rgb(184, 184, 184)
    static let gray5 = UIColor.rgb(100, 100, 100)

    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
    static var randomColor: UIColor {
        let red: CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
        let green: CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
        let bleue: CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
        return UIColor.rgb(red: red, green: green, blue: bleue)
    }
}
