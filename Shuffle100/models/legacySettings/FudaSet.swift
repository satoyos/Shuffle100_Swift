//
//  FudaSet.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/05/18.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct SerializedKey {
    static let status100         = "status100"
    static let fuda_set_name     = "fuda_set_name"
}

@objc (FudaSet)
class FudaSet: NSObject, NSCoding {
    var status100: SelectedStatus100
    var name: String

    func encode(with aCoder: NSCoder) {
        aCoder.encode(status100, forKey: SerializedKey.status100)
        aCoder.encode(name, forKey: SerializedKey.fuda_set_name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.status100 = aDecoder.decodeObject(forKey: SerializedKey.status100) as! SelectedStatus100
        self.name = aDecoder.decodeObject(forKey: SerializedKey.fuda_set_name) as! String
    }
    
}
