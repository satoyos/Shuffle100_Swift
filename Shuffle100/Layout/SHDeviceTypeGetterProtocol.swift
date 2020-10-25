//
//  SHDeviceTypeGetterProtocol.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/10/24.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import UIKit

protocol SHDeviceTypeGetter {
    var deviceType: UIUserInterfaceIdiom { get }
}

extension SHDeviceTypeGetter {
    var deviceType: UIUserInterfaceIdiom {
        UIDevice.current.userInterfaceIdiom
    }
}
