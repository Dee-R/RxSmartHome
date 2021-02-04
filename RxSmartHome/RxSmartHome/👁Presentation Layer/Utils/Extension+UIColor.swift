//
//  Extension+UIColor.swift
//  RxSmartHome
//
//  Created by Eddy R on 04/02/2021.
//

import UIKit

extension UIColor {
    
    static let gray1 = UIColor.rgb(240,240,240)
    static let gray2 = UIColor.rgb(224,224,224)
    static let gray3 = UIColor.rgb(208,208,208)
    static let gray4 = UIColor.rgb(184,184,184)
    static let gray5 = UIColor.rgb(144,144,144)
    
    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let mainBlue = UIColor.rgb(red: 0, green: 150, blue: 255)
    static var randomColor: UIColor {
        get {
            let r:CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
            let g:CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
            let b:CGFloat = CGFloat( arc4random_uniform(UInt32(250)) )
            return UIColor.rgb(red: r, green: g, blue: b)
        }
    }
}
