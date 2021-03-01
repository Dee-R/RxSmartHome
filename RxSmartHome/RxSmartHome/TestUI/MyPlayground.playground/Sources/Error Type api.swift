// import UIKit
// import PlaygroundSupport
//
// class MyViewController : UIViewController {
//    //    override func loadView() {
//    //        let view = UIView()
//    //        view.backgroundColor = .gray
//    //        view.frame = CGRect(origin: .zero, size: CGSize(width: 400, height: 600)) // default setting
//    //        self.view = view
//    //    }
//    // MARK: - Properties
//
//    // MARK: - Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        FoodService().getFood() { result in
//            switch(result) {
//                case .Success(let food):
//                    print(food)
//                case .Failure(let error):
//                    print(error)
//            }
//        }
//    }
//
//    private func getFood() {
//        FoodService().getFood() { [weak self] result in
//            print(result)
//        }
//    }
// }
//
//
//
// class FoodService {
//    func getFood(completion: @escaping (Result<String>)->Void ) {
//        completion(Result.Success("ok"))
//    }
// }
//
// enum Result<T> {
//    case Success(T)
//    case Failure(Error)
// }
//
//
// Present the view controller in the Live View window
// PlaygroundPage.current.liveView = MyViewController()
//
