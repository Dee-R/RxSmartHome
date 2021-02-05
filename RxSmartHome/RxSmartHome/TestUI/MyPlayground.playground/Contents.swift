import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    let fakevc1 = FakeVC1()
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 600)) // default setting
        self.view = view

    }
    // MARK: - Properties
    var contentView: UIView = UIView()
    
    
 
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // fake appdelegate
        
        //get ref of navigation controller
        
        
        
        fakevc1.goDetail {
            // donne index
            
        }
        
    }
    

    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


class FakeVC1 {
    init() {}
    func goDetail (comepltion:()->()) {
        comepltion()
    }
}
