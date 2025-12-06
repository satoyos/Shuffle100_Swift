////
////  GlyphIconProtocol.swift
////  Shuffle100
////
////  Created by Yoshifumi Sato on 2020/08/14.
////  Copyright © 2020 里 佳史. All rights reserved.
////
//
//import UIKit
//import FontAwesome_swift
//
//enum SOHGlyphIconType {
//  case play
//  case pause
//  case forward
//  case rewind
//}
//
//protocol SOHGlyphIcon {
//  func glyphFontOfSize(_ pointSize: CGFloat) -> UIFont
//  func stringExpression(of type: SOHGlyphIconType) -> String
//}
//
//extension SOHGlyphIcon {
//  func glyphFontOfSize(_ pointSize: CGFloat) -> UIFont {
//    return UIFont.fontAwesome(ofSize: pointSize, style: .regular)
//  }
//  
//  func stringExpression(of type: SOHGlyphIconType) -> String {
//    switch type {
//    case .play:
//      return String.fontAwesomeIcon(name: .play)
//    case .pause:
//      return String.fontAwesomeIcon(name: .pause)
//    case .forward:
//      return String.fontAwesomeIcon(name: .forward)
//    case .rewind:
//      return String.fontAwesomeIcon(name: .backward)
//    }
//  }
//}
//
//
