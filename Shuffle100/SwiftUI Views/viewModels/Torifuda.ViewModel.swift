//
//  Torifuda.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/05/03.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import Foundation

extension Torifuda {
    struct ViewModel {
        let shimo: String
        let strArray: [String]

        init(shimo: String) {
            self.shimo = shimo
            self.strArray = (shimo + "  ").splitInto(1)
        }
        
        func strForPosition(row: Int, col: Int) -> String {
            guard row >= 0 && row < 5 else { return ""}
            guard col >= 0 && col < 3 else { return ""}
            switch col {
            case 0:
                return strArray[10+row]
            case 1:
                return strArray[ 5+row]
            default: // row: 2
                return strArray[   row]
            }
        }
    }
    
}
