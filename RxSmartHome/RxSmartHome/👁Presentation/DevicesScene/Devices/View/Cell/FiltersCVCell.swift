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
    internal var filterButton: UIButton = {
        let l = UIButton()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.setTitle("Product type", for: .normal)
        l.setTitleColor(fontcolor, for: .normal)
        
        return l
    }()
    
    override init(frame: CGRect) { // code
        super.init(frame: frame)
        layer.masksToBounds = true
        self.clipsToBounds = true
        
        contentView.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filterButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filterButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    required init?(coder: NSCoder) { // SB
        fatalError("init(coder:) has not been implemented")
    }
}
