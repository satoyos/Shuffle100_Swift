//
//  SelectedState100.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/30.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

struct SelectedState100: Codable {
    static let defaultState = true
    var bools: Bool100
    
    init(bool100: Bool100 = Bool100.allSelected){
        bools = bool100
    }
}

extension SelectedState100: Equatable {
    // Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.bools == rhs.bools
    }
}

// static functions to create
extension SelectedState100 {
    static func createOf(bool: Bool) -> SelectedState100 {
        let initBool100 = get_bool100_of(bool: bool)
        return SelectedState100(bool100: initBool100)
    }
    
    private static func get_bool100_of(bool: Bool) -> Bool100 {
        if bool { return Bool100.allSelected}
        else { return Bool100.allUnselected}
    }
}

// looking up this object
extension SelectedState100 {
    var selectedNum: Int {
        bools.filter{$0 == true}.count
    }

    var allSelectedNumbers: [Int] {
        var  numbers = [Int]()
        for (index, bool) in bools.enumerated() {
            if bool { numbers.append(index + 1) }
        }
        return numbers
    }
    
    func ofNumber(_ number: Int) throws -> Bool {
        guard indexIsInBounds(number) else { throw NSError(domain: "indexが範囲外!", code: -1)
        }
        return bools[number - 1]
    }
}

// return new instance with modified state
extension SelectedState100 {
    func setStateOfNumber(state: Bool, index: Int) throws -> Self  {
        guard indexIsInBounds(index) else { throw NSError(domain: "indexが範囲外!", code: -1)
        }
        var newBools = bools
        newBools[index-1] = state
        return Self.init(bool100: newBools)
    }
    
    private func indexIsInBounds(_ index: Int) -> Bool {
        index >= 1 && index <= 100
    }
    
    func cancelAll() -> Self {
        Self.init(bool100: Bool100.allUnselected)
    }
    
    func selectAll() -> Self{
        Self.init(bool100: Bool100.allSelected)
    }
    
    func selectOf(number: Int) -> Self {
        guard let result = try? setStateOfNumber(state: true, index: number) else {
            fatalError("numberの値[\(number)]がサポート範囲外")
        }
        return result
    }
    
    func cancelOf(number: Int) -> Self {
        guard let result = try? setStateOfNumber(state: false, index: number) else {
            fatalError("numberの値[\(number)]がサポート範囲外")
        }
        return result
    }
    
    func selectInNumbers(_ array: [Int]) -> Self {
        var newSS100 = self
        for num in array {
            newSS100 = newSS100.selectOf(number: num)
        }
        return newSS100
    }
    
    func cancelInNumbers(_ array: [Int]) -> Self {
        var newSS100 = self
        for num in array {
            newSS100 = newSS100.cancelOf(number: num)
        }
        return newSS100
    }
    
    func reverseInIndex(_ idx: Int) -> Self {
        var newBools = bools
        newBools[idx].toggle()
        return Self.init(bool100: newBools)
    }
    
    func reverseInNumber(_ number: Int) -> Self {
        var newBools = bools
        newBools[number-1].toggle()
        return Self.init(bool100: newBools)
    }
}

// return deck(=[Poem]) created by self
extension SelectedState100 {
    func convertToDeck() -> [Poem] {
        PoemSupplier.Poem100.createFrom(state100: self)
    }
}
