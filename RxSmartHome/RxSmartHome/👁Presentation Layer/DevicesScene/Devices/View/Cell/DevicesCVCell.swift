//
//  DevicesCVCell.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

import UIKit

class DevicesCVCell: UICollectionViewCell {
    internal static let reuseID = "DevicesCVCell"
    internal var devicesButton: UIButton = {
        let l = UIButton()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.setTitle("-Devices-", for: .normal)
        l.setTitleColor(.gray5, for: .normal)
        return l
    }()
    
    override init(frame: CGRect) { // code
        super.init(frame: frame)
        
        layer.cornerRadius = 10 // set radius item
        layer.masksToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.gray4.cgColor
        self.clipsToBounds = false
        
        contentView.addSubview(devicesButton)
        NSLayoutConstraint.activate([
            devicesButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            devicesButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            devicesButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            devicesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { // SB
        fatalError("init(coder:) has not been implemented")
    }
}
