//
//  DigitsButtonViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/13.
//

import Combine

final class DigitsButtonViewModel<D: Digits>: ViewModelObject {
  
  // Input, Output, Binding
  final class Input: InputObject {
    let setFillType = PassthroughSubject<FillType, Never>()
  }
  final class Binding: BindingObject {}
  final class Output: OutputObject {
    @Published var fillType: FillType = .full
  }
  
  let input   = Input()
  @BindableObject private(set) var binding = Binding()
  let output  = Output()
  let digit: D
  private var cancellables = Set<AnyCancellable>()
  
  init(digit: D) {
    self.digit = digit
    
    input.setFillType
      .assign(to: \.fillType, on: output)
      .store(in: &cancellables)
  }
}

extension DigitsButtonViewModel {
  var numbersDescription: String {
    "歌番号: " +
    digit.poemNumbers.description
      .dropFirst()
      .dropLast()
  }
}
