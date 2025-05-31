//
//  NgramButtonViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/05/11.
//

import Combine

class NgramButtonViewModel: ViewModelObject {
  
  final class Input: InputObject {
    let setFillType = PassthroughSubject<FillType, Never>()
  }
  
  final class Binding: BindingObject {
  }
  
  final class Output: OutputObject {
    @Published var fillType: FillType = .full
  }
  

  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output
  
  let firstChar: FirstChar
  private var cancellables: Set<AnyCancellable> = []
  
  init(firstChar: FirstChar) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    self.firstChar = firstChar
    
    input.setFillType
      .assign(to: \.fillType, on: output)
      .store(in: &cancellables)
    
    self.input = input
    self.binding = binding
    self.output = output
  }
}
