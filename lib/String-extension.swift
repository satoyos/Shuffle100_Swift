//
//  String-extension.swift
//  WhatsNextScreen
//
//  Created by Yoshifumi Sato on 2020/05/02.
//  Copyright © 2020 Yoshifumi Sato. All rights reserved.
//

import Foundation

extension String {
    func splitInto(_ length: Int) -> [String] {
        var str = self
        for i in 0 ..< (str.count - 1) / max(length, 1) {
            str.insert(",", at: str.index(str.startIndex, offsetBy: (i + 1) * max(length, 1) + i))
        }
        return str.components(separatedBy: ",")
    }
}
