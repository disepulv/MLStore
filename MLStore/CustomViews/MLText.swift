//
//  MLText.swift
//  MLStore
//
//  Created by Diego Sepulveda on 22-04-24.
//

import SwiftUI

enum MLStyledTextType {
    case text
    case heading2XL
    case heading2XLR
    case headingXL
    case headingLG
    case textLGBold
    case textMDRegular
    case textMDMedium
    case textMDBold
    case textSMRegular
    case textSMMedium
    case textSMBold
    case textXSRegular

    // MARK: - Computed Properties

    var letterSpacing: CGFloat {
        switch self {
        case .text:
            return 0.64
        default:
            return 0
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .heading2XL, .heading2XLR:
            return 32
        case .headingXL:
            return 24
        case .headingLG ,.textLGBold:
            return 20
        case .textMDRegular, .textMDMedium, .textMDBold:
            return 18
        case .textSMRegular, .textSMMedium, .textSMBold, .text:
            return 16
        case .textXSRegular:
            return 14
        }
    }

    var fontFamily: Font.Weight {
        switch self {
        case .heading2XLR, .headingXL,.textMDRegular, .textSMRegular, .textXSRegular, .text:
            return .regular
        case .heading2XL, .headingLG, .textLGBold, .textMDBold, .textSMBold:
            return .bold
        case .textMDMedium, .textSMMedium:
            return .semibold
        }
    }
}

struct MLText: View {
    let content: String
    let style: MLStyledTextType
    var body: some View {
        let font = Font.system(size: style.fontSize, weight: style.fontFamily)

        let text = Text(content)
            .kerning(style.letterSpacing)
            .font(font)
        return text
    }

    init(_ content: String, style: MLStyledTextType = .text) {
        self.content = content
        self.style = style
    }
}
