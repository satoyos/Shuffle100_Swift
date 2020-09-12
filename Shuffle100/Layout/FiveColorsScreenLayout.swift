//
//  FiveColorsScreenLayout.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/09/12.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import UIKit

extension FiveColorsViewController {
    internal func layoutButtons() {
        
    }
    
    private func buttonSize() -> CGSize {
        return CGSize(width: viewWidth() * 0.8, height: sizes.whatsNextButtonHeight())
    }
    
    private func viewWidth() -> CGFloat {
        return view.frame.size.width
    }
    
    private func viewHeight() -> CGFloat {
        return view.frame.size.height
    }
    
    private func retinaSclae() -> CGFloat {
        return UIScreen.main.scale
    }
}
