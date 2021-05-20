//
//  SubLabel.swift
//  Trivia!
//
//  Created by David Boyd on 5/20/21.
//

import UIKit

class SubLabel: UILabel {
    
    override func awakeFromNib() {
        setupLabel()
    }
    
    func setupLabel() {
        self.textColor = Colors.customWhite
        updateFontTo(font: FontNames.appleSDGothicNeoUltraLight)
    }
    
    func updateFontTo(font: String) {
        guard let size = self.font?.pointSize else {return}
        self.font = UIFont(name: font, size: size)
    }
    
}//End of class
