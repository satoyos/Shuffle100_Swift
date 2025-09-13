//
//  FiveColorButtonViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/26.
//

import Combine

final class FiveColorButtonViewModel: ViewModelObject {
  
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
  
  let color: FiveColors
  private var cancellables: Set<AnyCancellable> = []
  
  init(color: FiveColors) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    
    input.setFillType
      .assign(to: \.fillType , on: output)
      .store(in: &cancellables)
    
    self.color = color
    self.input = input
    self.binding = binding
    self.output = output
    
  }
}


