//
//  SelectedState100.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/30.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

class SelectedState100 {
    static let defaultState = true
    var bools: Array<Bool>
    var selected_num: Int {
        get {
            return bools.filter{$0 == true}.count
        }
    }
    
    init(array: Array<Bool>){
        bools = array
    }
    
    static func create_of(bool: Bool) -> SelectedState100 {
        let init_bools = SelectedState100.get_array100_of(bool: bool)
        return SelectedState100(array: init_bools)
    }
    
    convenience init() {
        let init_value = SelectedState100.defaultState
        let init_bools = SelectedState100.get_array100_of(bool: init_value)
        self.init(array: init_bools)
    }
    
    private static func get_array100_of(bool: Bool) -> [Bool] {
        if bool { return Bool100.allTrueBoolArray() }
        else { return Bool100.allFalseBoolArray() }
    }
    
    func of_number(_ number: Int) throws -> Bool {
        if number < 1 || number > 100 {
            throw NSError(domain: "indexが範囲外!", code: -1)
        } else {
            return bools[number-1]
        }
    }
    
    func set_state_of_number(state: Bool, index: Int) throws {
        if index < 1 || index > 100 {
            throw NSError(domain: "indexが範囲外!", code: -1)
        } else {
            bools[index-1] = state
        }
    }
    
    func cancel_all() {
        self.bools = SelectedState100.get_array100_of(bool: false)
    }
    
    func select_all() {
        self.bools = SelectedState100.get_array100_of(bool: true)
    }
    
    func select_of(number: Int) {
        do {
            try self.set_state_of_number(state: true, index: number)
        } catch {
            print("numberの値[\(number)]がサポート範囲外")
            exit(2)
        }
    }
    
    func cancel_of(number: Int) {
        do {
            try self.set_state_of_number(state: false, index: number)
        } catch {
            print("numberの値[\(number)]がサポート範囲外")
            exit(2)
        }
    }
    
    func select_in_numbers(_ array: Array<Int>) {
        for num in array {
            select_of(number: num)
        }
    }
    
    func cancel_in_numbers(_ array: Array<Int>) {
        for num in array {
            cancel_of(number: num)
        }
    }
    
    func reverse_in_index(_ idx: Int) {
        self.bools[idx] = !self.bools[idx]
    }
}
