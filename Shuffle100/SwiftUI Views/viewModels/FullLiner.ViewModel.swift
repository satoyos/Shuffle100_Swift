//
//  FullLiner.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/05/03.
//  Copyright © 2024 里 佳史. All rights reserved.
//

import Foundation

extension FullLiner {
    struct ViewModel {
        let fullLiner: [String]
        
        var text: String {
            guard fullLiner.count == 5 else { return ""}
            return fullLiner[0] + " "
            + fullLiner[1] + " "
            + fullLiner[2] + "\n"
            + fullLiner[3] + " "
            + fullLiner[4]
        }
    }
    
}
