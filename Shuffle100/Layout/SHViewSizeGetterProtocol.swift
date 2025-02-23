//
//  SHViewSizeGetterProtocol.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/09/15.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

protocol SHViewSizeGetter {
  var viewWidth: CGFloat { get }
  var viewHeight: CGFloat { get }
}

extension SHViewSizeGetter where Self: Screen {
  var viewWidth: CGFloat {
    view.frame.size.width
  }
  
  var viewHeight: CGFloat {
    view.frame.size.height
  }
}


