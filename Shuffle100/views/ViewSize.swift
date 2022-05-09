//
//  ViewSize.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

private let skipButtonHeightBase: CGFloat = 40
private let intervalTimeLabelSizeBase: CGFloat = 100
private let intervalSliderHeightBase = intervalTimeLabelSizeBase * 4 / 10
private let imageOffsetXBase: CGFloat = 30
private let whatsNextButtonHeightBase: CGFloat = 50
private let memorizeTimerLabelSizeBase: CGFloat = 100

protocol SizeByDevice {
    func playButtonHeight() -> CGFloat
    func skipButtonHeight() -> CGFloat
    func intervalTimeLabelPointSize() -> CGFloat
    func intervalSiderHeight() -> CGFloat
    func whatsNextButtonHeight() -> CGFloat
    func imageOffsetX() -> CGFloat
    func fudaSetPickerWidth() -> CGFloat
    func memorizeTimerLabelPointSize() -> CGFloat
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

class PhoneSize: SizeByDevice, AppWindow {
    func playButtonHeight() -> CGFloat {
        keyWindow.bounds.width * 300 / 375
    }
    
    func skipButtonHeight() -> CGFloat {
        skipButtonHeightBase
    }
    
    func intervalTimeLabelPointSize() -> CGFloat {
        intervalTimeLabelSizeBase
    }
    
    func intervalSiderHeight() -> CGFloat {
        intervalSliderHeightBase
    }
    
    func whatsNextButtonHeight() -> CGFloat {
        whatsNextButtonHeightBase
    }
    
    func imageOffsetX() -> CGFloat {
        imageOffsetXBase
    }
    
    func fudaSetPickerWidth() -> CGFloat {
        270
    }
    
    func memorizeTimerLabelPointSize() -> CGFloat {
        memorizeTimerLabelSizeBase
    }
    

}

class PadSize: SizeByDevice, AppWindow {
    func playButtonHeight() -> CGFloat {
        keyWindow.bounds.width * 2 / 3
    }
    
    func skipButtonHeight() -> CGFloat {
        skipButtonHeightBase * 2
    }
    
    func intervalTimeLabelPointSize() -> CGFloat {
        intervalTimeLabelSizeBase * 2
    }
    
    func intervalSiderHeight() -> CGFloat {
        intervalSliderHeightBase * 2
    }
    
    func whatsNextButtonHeight() -> CGFloat {
        whatsNextButtonHeightBase * 2
    }
    
    func imageOffsetX() -> CGFloat {
        imageOffsetXBase * 2
    }
    
    func fudaSetPickerWidth() -> CGFloat {
        270
    }
    
    func memorizeTimerLabelPointSize() -> CGFloat {
        memorizeTimerLabelSizeBase * 2
    }
}
