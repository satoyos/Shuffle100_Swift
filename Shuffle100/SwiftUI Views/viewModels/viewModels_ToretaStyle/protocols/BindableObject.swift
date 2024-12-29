//
//  BindableObject.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/02.
//

import SwiftUI

@propertyWrapper struct BindableObject<T: BindingObject> {
    
    @dynamicMemberLookup struct Wrapper {
        fileprivate let binding: T
        subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<T, Value>) -> Binding<Value> {
            return .init(
                get: { self.binding[keyPath: keyPath]},
                set: { self.binding[keyPath: keyPath] = $0 }
            )
        }
    }
    
    var wrappedValue: T
    
    var projectedValue: Wrapper {
        return Wrapper(binding: wrappedValue)
    }
}
