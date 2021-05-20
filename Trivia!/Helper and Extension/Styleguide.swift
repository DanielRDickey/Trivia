//
//  Styleguide.swift
//  Trivia!
//
//  Created by David Boyd on 5/20/21.
//

import UIKit

struct Colors {
    static let backgroundBlack = UIColor(named: "backgroundBlack")
    static let customWhite = UIColor(named: "customWhite")
    static let customGrey = UIColor(named: "customGrey")
}

struct FontNames {
    static let appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    static let appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    static let appleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
}

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
    }
    
    func addAccentBorder(width: CGFloat = 1, color: UIColor = Colors.customGrey!) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
