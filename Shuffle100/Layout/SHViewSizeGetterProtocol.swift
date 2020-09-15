//
//  SHViewSizeGetterProtocol.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/09/15.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

protocol SHViewSizeGetter {
    var view: UIView! { get }
    func viewWidth() -> CGFloat
    func viewHeight() -> CGFloat
}

extension SHViewSizeGetter {
    func viewWidth() -> CGFloat {
        return view.frame.size.width
    }
    
    func viewHeight() -> CGFloat {
        return view.frame.size.height
    }
}


