//
//  StringExtension.swift
//  MLStore
//
//  Created by Diego Sepulveda on 23-04-24.
//

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    var isNotEmpty: Bool {
        !self.isEmpty
    }
}
