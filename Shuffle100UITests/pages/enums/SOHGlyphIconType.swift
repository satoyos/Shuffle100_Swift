//
//  SOHGlyphIconType.swift
//  Shuffle100UITests
//
//  Created by Yoshifumi Sato on 2024/03/24.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import FontAwesome_swift

enum SOHGlyphIconType {
    case play
    case pause
    case forward
    case rewind
}

func stringExpression(of type: SOHGlyphIconType) -> String {
    switch type {
    case .play:
        return String.fontAwesomeIcon(name: .play)
    case .pause:
        return String.fontAwesomeIcon(name: .pause)
    case .forward:
        return String.fontAwesomeIcon(name: .forward)
    case .rewind:
        return String.fontAwesomeIcon(name: .backward)
    }
}
