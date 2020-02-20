//
//  Environment.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2020/02/20.
//  Copyright © 2020 里 佳史. All rights reserved.
//

import Foundation

class Environment {
    private var wontSave: Bool
    private var ignoreSaved: Bool
    
    init() {
        self.wontSave = (ProcessInfo.processInfo.environment["WONT_SAVE_DATA"] == "1")
        self.ignoreSaved = (ProcessInfo.processInfo.environment["IGNORE_SAVED_DATA"] == "1")
    }
    
    func wontSaveData() -> Bool {
        return wontSave
    }
    
    func ignoreSavedData() -> Bool {
        return ignoreSaved
    }
    
    func setEnvWillSaveData() {
        self.wontSave = false
    }
    
    func setEnvWontSaveData() {
        self.wontSave = true
    }
    
    func setEnvLoadSavedData() {
        self.ignoreSaved = false
    }
    
    func setEnvIgnoreSavedData() {
        self.ignoreSaved = true
    }
}
