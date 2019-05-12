//
//  SelectedStatus100.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/12.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation

fileprivate struct SerializedKey {
    static let status100 = "status100"
}

@objc (SelectedStatus100)
class SelectedStatus100: NSObject, NSCoding {
    var status: [Bool]
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(status, forKey: SerializedKey.status100)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.status = aDecoder.decodeObject(forKey: SerializedKey.status100) as! [Bool]
    }
    
    init(status:[Bool] = [Bool](repeating: true, count: 100)) {
        self.status = status
    }
}
