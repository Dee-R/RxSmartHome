//
//  DevicesCVCell.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.

import UIKit

class DevicesCVCell: UICollectionViewCell {
    internal static let reuseID = "DevicesCVCell"
  
    internal var deviceImage: UIImageView = {
        let image = UIImage(named: "router.png")
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    internal var deviceTitle: UILabel = {
        var label = UILabel()
        label = UILabel(frame: .zero)
        label.text = "Product Type - Name room"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.allowsDefaultTighteningForTruncation = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    internal var deviceInfo: UILabel = {
        var label = UILabel()
        label = UILabel(frame: .zero)
        label.text = "0% - Off "
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
//    internal deviceInfo: UILabel = {}()
        
    override init(frame: CGRect) { // code
        super.init(frame: frame)
        // -- content --
        contentView.clipsToBounds = true
        layer.cornerRadius = 10 // set radius item
        layer.masksToBounds = true
        layer.borderWidth = 0
        layer.borderColor = UIColor.white.cgColor
        
        // -- image --
        contentView.addSubview(deviceImage)
        NSLayoutConstraint.activate([
            deviceImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            deviceImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            deviceImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            deviceImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
        
        // -- info --
        contentView.addSubview(deviceTitle)
        NSLayoutConstraint.activate([
            deviceTitle.topAnchor.constraint(equalTo: deviceImage.bottomAnchor),
            deviceTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            deviceTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            deviceTitle.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ])
        contentView.addSubview(deviceInfo)
        NSLayoutConstraint.activate([
            deviceInfo.topAnchor.constraint(equalTo: deviceTitle.bottomAnchor),
            deviceInfo.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            deviceInfo.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            deviceInfo.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)
        ])
    }
    required init?(coder: NSCoder) { // SB
        fatalError("init(coder:) has not been implemented")
    }
}
