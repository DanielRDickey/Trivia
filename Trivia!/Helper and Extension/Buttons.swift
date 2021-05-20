//
//  Buttons.swift
//  Trivia!
//
//  Created by David Boyd on 5/20/21.
//

import UIKit

class Buttons: UIButton {
    
    override func awakeFromNib() {
        setupButtons()
    }
    
    func setupButtons() {
        updateFontTo(font: FontNames.appleSDGothicNeoBold)
        setTitleColor(.black, for: .normal)
        self.backgroundColor = Colors.customWhite
        self.addCornerRadius()
        self.addAccentBorder()
    }
    
    func updateFontTo(font: String) {
        guard let size = self.titleLabel?.font.pointSize else {return}
        self.titleLabel?.font = UIFont(name: font, size: size)
    }
    
}
