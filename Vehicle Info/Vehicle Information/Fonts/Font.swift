//
//  Font.swift
//  Vehicle Information
//
//  Created by apple on 13/09/24.
//

import Foundation
import UIKit

extension UIFont {
    static func openSansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func openSansBold(size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
