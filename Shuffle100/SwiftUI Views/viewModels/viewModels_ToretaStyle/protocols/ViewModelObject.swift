//
//  ViewModelObject.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/02.
//

import Combine

protocol ViewModelObject: ObservableObject {
  
  associatedtype Input: InputObject
  associatedtype Binding: BindingObject
  associatedtype Output: OutputObject
  
  var input: Input { get }
  var binding: Binding { get }
  var output: Output { get }
}

extension ViewModelObject where
Binding.ObjectWillChangePublisher == ObservableObjectPublisher, Output.ObjectWillChangePublisher ==ObservableObjectPublisher {
  
  var objectWillChange: AnyPublisher<Void, Never> {
    Publishers.Merge(binding.objectWillChange, output.objectWillChange).eraseToAnyPublisher()
  }
  
}


protocol InputObject: AnyObject {
}

protocol BindingObject: ObservableObject {
}

protocol OutputObject: ObservableObject {
}
