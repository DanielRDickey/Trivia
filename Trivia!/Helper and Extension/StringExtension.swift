//
//  StringExtension.swift
//  Trivia!
//
//  Created by David Boyd on 5/20/21.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
