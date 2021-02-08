//
//  FiltersCVCell.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//
import UIKit

class FiltersCVCell: UICollectionViewCell {
    internal static let reuseID = "FiltersCVCell"
    private static let fontcolor: UIColor = .gray5
    internal var filterLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Product type"
        l.textColor = fontcolor
        return l
    }()
    
    override init(frame: CGRect) { // code
        super.init(frame: frame)
        layer.masksToBounds = true
        self.clipsToBounds = true
        
        contentView.addSubview(filterLabel)
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filterLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { // SB
        fatalError("init(coder:) has not been implemented")
    }
}
