////
////  ViewSize.swift
////  Shuffle100
////
////  Created by 里 佳史 on 2019/07/13.
////  Copyright © 2019 里 佳史. All rights reserved.
////
//
//import UIKit
//
//private let skipButtonHeightBase: CGFloat = 40
//private let intervalTimeLabelSizeBase: CGFloat = 100
//private let intervalSliderHeightBase = intervalTimeLabelSizeBase * 4 / 10
//private let imageOffsetXBase: CGFloat = 30
//private let whatsNextButtonHeightBase: CGFloat = 50
//private let memorizeTimerLabelSizeBase: CGFloat = 100
//
//protocol SizeByDevice {
//  var playButtonHeight: CGFloat { get }
//  var skipButtonHeight: CGFloat { get }
//  var intervalTimeLabelPointSize: CGFloat { get }
//  var intervalSiderHeight: CGFloat { get }
//  var whatsNextButtonHeight: CGFloat { get }
//  var imageOffsetX: CGFloat { get }
//  var fudaSetPickerWidth: CGFloat { get }
//  var memorizeTimerLabelPointSize: CGFloat { get }
//}
//
//class SizeFactory {
//  static func createSizeByDevice() -> SizeByDevice {
//    switch UIDevice.current.userInterfaceIdiom {
//    case .phone:
//      return PhoneSize()
//    case .pad:
//      return PadSize()
//    default:
//      fatalError("This Device is not supported. Idiom => \(UIDevice.current.userInterfaceIdiom)")
//    }
//  }
//}
//
//class PhoneSize: SizeByDevice, AppWindow {
//  var playButtonHeight: CGFloat {
//    keyWindow.bounds.width * 300 / 375
//  }
//  
//  var skipButtonHeight: CGFloat {
//    skipButtonHeightBase
//  }
//  
//  var intervalTimeLabelPointSize: CGFloat {
//    intervalTimeLabelSizeBase
//  }
//  
//  var intervalSiderHeight: CGFloat {
//    intervalSliderHeightBase
//  }
//  
//  var whatsNextButtonHeight: CGFloat {
//    whatsNextButtonHeightBase
//  }
//  
//  var imageOffsetX: CGFloat {
//    imageOffsetXBase
//  }
//  
//  var fudaSetPickerWidth: CGFloat {
//    270
//  }
//  
//  var memorizeTimerLabelPointSize: CGFloat {
//    memorizeTimerLabelSizeBase
//  }
//  
//  
//}
//
//class PadSize: SizeByDevice, AppWindow {
//  var playButtonHeight: CGFloat {
//    keyWindow.bounds.width * 2 / 3
//  }
//  
//  var skipButtonHeight: CGFloat {
//    skipButtonHeightBase * 2
//  }
//  
//  var intervalTimeLabelPointSize: CGFloat {
//    intervalTimeLabelSizeBase * 2
//  }
//  
//  var intervalSiderHeight: CGFloat {
//    intervalSliderHeightBase * 2
//  }
//  
//  var whatsNextButtonHeight: CGFloat {
//    whatsNextButtonHeightBase * 2
//  }
//  
//  var imageOffsetX: CGFloat {
//    imageOffsetXBase * 2
//  }
//  
//  var fudaSetPickerWidth: CGFloat {
//    270
//  }
//  
//  var memorizeTimerLabelPointSize: CGFloat {
//    memorizeTimerLabelSizeBase * 2
//  }
//}
