//
//  File.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

private let skipButtonHeightBase: CGFloat = 30

protocol SizeByDevice {
    func playButtonHeight() -> CGFloat
    func skipButtonHeight() -> CGFloat
}

class SizeFactory {
    static func createSizeByDevice() -> SizeByDevice {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return PhoneSize()
        case .pad:
            return PadSize()
        default:
            fatalError("This Device is not supported. Idiom => \(UIDevice.current.userInterfaceIdiom)")
        }
    }
}

class PhoneSize: SizeByDevice {
    func playButtonHeight() -> CGFloat {
        return UIApplication.shared.keyWindow!.bounds.width * 300 / 375
    }
    
    func skipButtonHeight() -> CGFloat {
        return skipButtonHeightBase
    }
}

class PadSize: SizeByDevice {
    func playButtonHeight() -> CGFloat {
        return UIApplication.shared.keyWindow!.bounds.width * 2 / 3
    }
    
    func skipButtonHeight() -> CGFloat {
        return skipButtonHeightBase * 2
    }
}

