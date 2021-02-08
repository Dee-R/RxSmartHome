/// MARK: - VIEWMODEL
//  DevicesViewModel.swift
//  Created by Eddy R on 08/02/2021.
import Foundation
import RxSwift
import RxCocoa

// 👁👁🤝
protocol DevicesViewModelInput {
    func showDevices()
}
protocol DevicesViewModelOutput {
    var dataFilter: BehaviorSubject<[Int]> {get set}
    var dataDevices: BehaviorSubject<[Int]> {get set}
}
protocol DeviceViewModel: DevicesViewModelInput, DevicesViewModelOutput {}

// ⛔️⛔️
class DevicesViewModelImpl: DeviceViewModel {
    var interactor: DevicesInteractor
    internal var dataFilter = BehaviorSubject<[Int]>(value: []) //    fileprivate var dataDevices = BehaviorSubject<[Int]>(value: Array(0...10))
    internal var dataDevices = BehaviorSubject<[Int]>(value: [])
    // ---
    init() {
        print("  L\(#line) [✴️\(type(of: self))  ✴️\(#function) ] ")
        self.interactor = DevicesInteractorImpl()
    }
    func showDevices() {
        // demande interactor
        interactor.getDevices { (devicesArr) in
            // TODO: format les datas
            dataFilter.onNext(devicesArr)
            dataDevices.onNext(devicesArr)
        }
    }
}
