// import UIKit
// import PlaygroundSupport
//
// class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .gray
//        view.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 600)) // default setting
//        self.view = view
//        
//    }
//    // MARK: - Properties
//    var contentView: UIView = UIView()
//    var devicesTitle: UILabel!
//    var devicesInfo: UILabel!
//    
//    
//    // MARK: - Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // -- content --
//        contentView.frame = CGRect(x: 0, y: 0, width:200, height: 150)
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 10
//        contentView.layer.borderWidth = 0.2
//        contentView.layer.borderColor = UIColor.orange.cgColor
//        contentView.clipsToBounds = true
//        view.addSubview(contentView)
//        
//        // -- image --
//        let imageDevices = UIImage(named: "router.png")
//        let imageDevicesView = UIImageView(image: imageDevices)
//        imageDevicesView.contentMode = .scaleAspectFit
//        imageDevicesView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(imageDevicesView)
//        NSLayoutConstraint.activate([
//            imageDevicesView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageDevicesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageDevicesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageDevicesView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
//        ])
//        
//        // -- devices Title --
//        devicesTitle = UILabel(frame: .zero)
//        devicesTitle.text = "Light - Cuisine"
//        devicesTitle.textColor = .black
//        devicesTitle.font = UIFont.systemFont(ofSize: 15)
//        devicesTitle.backgroundColor = .white
//        devicesTitle.translatesAutoresizingMaskIntoConstraints = false
//        devicesTitle.textAlignment = .center
//        contentView.addSubview(devicesTitle)
//        NSLayoutConstraint.activate([
//            devicesTitle.topAnchor.constraint(equalTo: imageDevicesView.bottomAnchor),
//            devicesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            devicesTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            devicesTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
//        ])
//        
//        // -- Device Info --
//        devicesInfo = UILabel(frame: .zero)
//        devicesInfo.text = "On - 100%"
//        devicesInfo.font = UIFont.systemFont(ofSize: 15)
//        devicesInfo.textColor = .black
//        devicesInfo.backgroundColor = .white
//        devicesInfo.translatesAutoresizingMaskIntoConstraints = false
//        devicesInfo.textAlignment = .center
//        contentView.addSubview(devicesInfo)
//        NSLayoutConstraint.activate([
//            devicesInfo.topAnchor.constraint(equalTo: devicesTitle.bottomAnchor),
//            devicesInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            devicesInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            devicesInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
// }
//
// Present the view controller in the Live View window
// PlaygroundPage.current.liveView = MyViewController()
//
