//
//  SelectedState100.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/30.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

struct SelectedState100: Codable, Equatable {
    static let defaultState = true
    var bools: Bool100
    var selectedNum: Int {
        get {
            return bools.filter{$0 == true}.count
        }
    }
    
    init(bool100: Bool100 = Bool100.allSelected){
        bools = bool100
    }

    // Equatable
    static func == (lhs: SelectedState100, rhs: SelectedState100) -> Bool {
        lhs.bools == rhs.bools
    }
      
    static func createOf(bool: Bool) -> SelectedState100 {
        let initBool100 = SelectedState100.get_bool100_of(bool: bool)
        return SelectedState100(bool100: initBool100)
    }
    
    var allSelectedNumbers: [Int] {
        get {
            var  numbers = [Int]()
            for i in 0 ..< 100 {
                if bools[i] { numbers.append(i+1) }
            }
            return numbers
        }
    }
    
    private static func get_bool100_of(bool: Bool) -> Bool100 {
        if bool { return Bool100.allSelected}
        else { return Bool100.allUnselected}
    }
    
    func ofNumber(_ number: Int) throws -> Bool {
        if number < 1 || number > 100 {
            throw NSError(domain: "indexが範囲外!", code: -1)
        } else {
            return bools[number-1]
        }
    }
    
    mutating func setStateOfNumber(state: Bool, index: Int) throws {
        if index < 1 || index > 100 {
            throw NSError(domain: "indexが範囲外!", code: -1)
        } else {
            bools[index-1] = state
        }
    }
    
    mutating func cancelAll() {
        self.bools = Bool100.allUnselected
    }
    
    mutating func selectAll() {
        self.bools = Bool100.allSelected
    }
    
    mutating func selectOf(number: Int) {
        do {
            try self.setStateOfNumber(state: true, index: number)
        } catch {
            fatalError("numberの値[\(number)]がサポート範囲外")
        }
    }
    
    mutating func cancelOf(number: Int) {
        do {
            try self.setStateOfNumber(state: false, index: number)
        } catch {
            print("numberの値[\(number)]がサポート範囲外")
            exit(2)
        }
    }
    
    mutating func selectInNumbers(_ array: Array<Int>) {
        for num in array {
            selectOf(number: num)
        }
    }
    
    mutating func cancelInNumbers(_ array: Array<Int>) {
        for num in array {
            cancelOf(number: num)
        }
    }
    
    mutating func reverseInIndex(_ idx: Int) {
        self.bools[idx].toggle()
    }
    
    mutating func reverseInNumber(_ number: Int) {
        self.bools[number-1].toggle()
    }
}
