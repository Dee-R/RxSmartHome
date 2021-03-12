//  VIEWMODEL Presenter
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
    var dataFilter: BehaviorSubject<[String]> {get set}
    var dataDevices: BehaviorSubject<[String]> {get set}
}
protocol DeviceViewModel: DevicesViewModelInput, DevicesViewModelOutput {}

// ⛔️⛔️
class DevicesViewModel: DeviceViewModel {
    var interactor: DevicesInteractor
    internal var dataFilter = BehaviorSubject<[String]>(value: [])
    //    fileprivate var dataDevices = BehaviorSubject<[Int]>(value: Array(0...10))
    internal var dataDevices = BehaviorSubject<[String]>(value: [])
    // ---
    init() {
        self.interactor = DevicesInteractor()
    }
    func showDevices() {
        // demande interactor
        interactor.getDevices { [weak self] (devicesArr) in
            guard let this = self else {return}
            print(devicesArr)

//            let datafilterReceived = ["Toto", "tata", "titi"]
//            let dataDevicesReceived = ["Toto", "tata", "titi"]


            // get all product device
            let arrayDeviceProductDevices = devicesArr.map { (device) -> String in
                return (device.deviceName ?? "device ???")
            }

            // get all product filter
            let arrayDeviceProductFilter = devicesArr.map { (device) -> String in
                return device.productType?.rawValue ?? ""
            }


            // set view
            let dataDevicesReceived = arrayDeviceProductDevices
            let datafilterReceived = arrayDeviceProductFilter

            this.dataFilter.onNext(datafilterReceived)
            this.dataDevices.onNext(dataDevicesReceived)
        }
    }
}
