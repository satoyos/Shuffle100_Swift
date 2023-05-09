//
//  PoemsSelectesStatus.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/10/03.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

enum PoemsSelectedState {
    case full
    case partial
    case empry
}

protocol PoemSelectedStateHandler {
    func selectedState(of someNumbers: [Int],
                       in referenceNumbers: [Int]) -> PoemsSelectedState
}

extension PoemSelectedStateHandler {
    func selectedState(of someNumbers: [Int],
                        in referenceNumbers: [Int]) -> PoemsSelectedState {
        comparePoemNumbers(selected: Set(someNumbers),
                           in: Set(referenceNumbers))
    }
     
    
    private func comparePoemNumbers(selected: Set<Int>, in reference: Set<Int>) -> PoemsSelectedState {
        let intersection = selected.intersection(reference)
        if intersection.isEmpty {
            return .empry
        } else if intersection == reference {
            return .full
        } else {
            return .partial
        }
    }
}
