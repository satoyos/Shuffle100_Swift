//
//  DigitsPickerViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/07/16.
//

import Combine

final class DigitsPickerViewModel<D: Digits>: ViewModelObject, FillTypeHandlable {
  // 共通 Input/Binding/Output
  final class Input: InputObject {
    let digitButtonTapped = PassthroughSubject<D, Never>()
  }
  final class Binding: BindingObject {}
  final class Output: OutputObject {
    @Published var state100: SelectedState100 = .init()
  }
  
  let input   = Input()
  @BindableObject private(set) var binding = Binding()
  let output  = Output()
  private var cancellables = Set<AnyCancellable>()
  
  init(state100: SelectedState100) {
    output.state100 = state100
    
    // 初期表示の fillType 設定
    D.allCases.forEach { digit in
      let ft = Self.fillType(of: digit, for: state100)
      digit.buttonViewModel.input.setFillType.send(ft)
    }
    // タップ時の toggle ロジック
    input.digitButtonTapped
      .sink { digit in
        let currentFT = digit.buttonViewModel.output.fillType
        let currentState = self.output.state100
        switch currentFT {
        case .full:
          self.output.state100 = currentState.cancelInNumbers(digit.poemNumbers)
          digit.buttonViewModel.input.setFillType.send(.empty)
        default:
          self.output.state100 = currentState.selectInNumbers(digit.poemNumbers)
          digit.buttonViewModel.input.setFillType.send(.full)
        }
      }
      .store(in: &cancellables)
  }
}

extension DigitsPickerViewModel {
  var selectedNum: Int {
    output.state100.selectedNum
  }
}

extension DigitsPickerViewModel {
  // fillType 計算（FillTypeHandlable のヘルパーを呼び出し）
  static func fillType(of digit: D,
                       for state100: SelectedState100) -> FillType
  {
    fillType(of: state100.allSelectedNumbers,
             in: digit.poemNumbers)
  }
}
