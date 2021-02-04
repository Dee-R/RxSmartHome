//
//  DevicesCVCell.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.

import UIKit

class DevicesCVCell: UICollectionViewCell {
    internal static let reuseID = "DevicesCVCell"
    private static let fontcolor: UIColor = .gray5
    
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
        label.textColor = fontcolor
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
        label.textColor = fontcolor
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
    override func layoutSubviews() {
//         cell rounded section
        super.layoutSubviews() // allow to capture the final render otherwith content view got the default size
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.2
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
