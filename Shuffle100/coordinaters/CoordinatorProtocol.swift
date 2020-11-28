//
//  CoordinatorProtocol.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/08/04.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }

    func start()
    func navigationItemPrompt() -> String
}

extension Coordinator {
    func navigationItemPrompt() -> String {
        return "百首読み上げ"
    }
}
