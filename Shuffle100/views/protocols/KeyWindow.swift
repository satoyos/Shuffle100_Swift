//
//  KeyWindow.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2022/05/08.
//  Copyright © 2022 里 佳史. All rights reserved.
//

import UIKit

protocol AppWindow {
    var keyWindow: UIWindow { get }
}

extension AppWindow {
    var keyWindow: UIWindow {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        if let window = windowScenes?.windows.first{
            return window
        } else {
            fatalError("Couldn't get KeyWindow...")
        }
    }
}
