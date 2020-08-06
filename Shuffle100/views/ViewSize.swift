//
//  ViewSize.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/07/13.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

private let skipButtonHeightBase: CGFloat = 30
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

class PhoneSize: SizeByDevice {
    func playButtonHeight() -> CGFloat {
        return keyWindow().bounds.width * 300 / 375
    }
    
    func skipButtonHeight() -> CGFloat {
        return skipButtonHeightBase
    }
    
    func intervalTimeLabelPointSize() -> CGFloat {
        return intervalTimeLabelSizeBase
    }
    
    func intervalSiderHeight() -> CGFloat {
        return intervalSliderHeightBase
    }
    
    func whatsNextButtonHeight() -> CGFloat {
        return whatsNextButtonHeightBase
    }
    
    func imageOffsetX() -> CGFloat {
        return imageOffsetXBase
    }
    
    func fudaSetPickerWidth() -> CGFloat {
        return 270
    }
    
    func memorizeTimerLabelPointSize() -> CGFloat {
        return memorizeTimerLabelSizeBase
    }
    

}

class PadSize: SizeByDevice {
    func playButtonHeight() -> CGFloat {
        return keyWindow().bounds.width * 2 / 3
    }
    
    func skipButtonHeight() -> CGFloat {
        return skipButtonHeightBase * 2
    }
    
    func intervalTimeLabelPointSize() -> CGFloat {
        return intervalTimeLabelSizeBase * 2
    }
    
    func intervalSiderHeight() -> CGFloat {
        return intervalSliderHeightBase * 2
    }
    
    func whatsNextButtonHeight() -> CGFloat {
        return whatsNextButtonHeightBase * 2
    }
    
    func imageOffsetX() -> CGFloat {
        return imageOffsetXBase * 2
    }
    
    func fudaSetPickerWidth() -> CGFloat {
        return 270
    }
    
    func memorizeTimerLabelPointSize() -> CGFloat {
        return memorizeTimerLabelSizeBase * 2
    }
}

private func keyWindow() -> UIWindow {
    if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
        return window
    } else {
        fatalError("KeyWindowが取得できません")
    }
}
