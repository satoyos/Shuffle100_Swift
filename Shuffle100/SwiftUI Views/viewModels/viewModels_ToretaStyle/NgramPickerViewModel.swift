//
//  NgramPickerViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/05/14.
//

import Combine

final class NgramPickerViewModel: ViewModelObject, FillTypeHandlable {
  
  final class Input: InputObject {
    let chrButotnTapped = PassthroughSubject<FirstChar, Never>()
  }
  
  final class Binding: BindingObject {
  }
  
  final class Output: OutputObject {
    @Published var state100: SelectedState100 = .init()
  }
  
  let input: Input
  @BindableObject private(set) var binding:  Binding
  let output: Output
  private var cancellables: Set<AnyCancellable> = []

  init(state100: SelectedState100) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    
    output.state100 = state100
    
    FirstChar.allCases.forEach { firstChar in
      let fillType = Self.fillType(of: firstChar, for: state100)
      firstChar.buttonViewModel.input.setFillType.send(fillType)
    }
    
    input.chrButotnTapped
      .sink { firstChar in
        let currentFillType = firstChar.buttonViewModel.output.fillType
        let currentState100 = output.state100
        switch currentFillType {
        case .full:
          output.state100 = currentState100.cancelInNumbers(firstChar.poemNumbers)
          firstChar.buttonViewModel.input.setFillType.send(.empty)
        default:
          output.state100 = currentState100.selectInNumbers(firstChar.poemNumbers)
          firstChar.buttonViewModel.input.setFillType.send(.full)
        }
      }
      .store(in: &cancellables)
    
    self.input = input
    self.binding = binding
    self.output = output
  }
}

extension NgramPickerViewModel {
  var selectedNum: Int {
    output.state100.selectedNum
  }
}

extension NgramPickerViewModel {
  static func fillType(of firstChar: FirstChar, for state100: SelectedState100) -> FillType {
    fillType(of: state100.allSelectedNumbers, in: firstChar.poemNumbers)
  }
}

fileprivate let justOneButtonViewModel = NgramButtonViewModel(firstChar: .justOne)
fileprivate let uButtonViewModel = NgramButtonViewModel(firstChar: .u)
fileprivate let tsuButtonViewModel = NgramButtonViewModel(firstChar: .tsu)
fileprivate let shiButtonViewModel = NgramButtonViewModel(firstChar: .shi)
fileprivate let moButtonViewModel = NgramButtonViewModel(firstChar: .mo)
fileprivate let yuButtonViewModel = NgramButtonViewModel(firstChar: .yu)
fileprivate let iButtonViewModel = NgramButtonViewModel(firstChar: .i)
fileprivate let chiButtonViewModel = NgramButtonViewModel(firstChar: .chi)
fileprivate let hiButtonViewModel = NgramButtonViewModel(firstChar: .hi)
fileprivate let kiButtonViewModel = NgramButtonViewModel(firstChar: .ki)
fileprivate let haButtonViewModel = NgramButtonViewModel(firstChar: .ha)
fileprivate let yaButtonViewModel = NgramButtonViewModel(firstChar: .ya)
fileprivate let yoButtonViewModel = NgramButtonViewModel(firstChar: .yo)
fileprivate let kaButtonViewModel = NgramButtonViewModel(firstChar: .ka)
fileprivate let miButtonViewModel = NgramButtonViewModel(firstChar: .mi)
fileprivate let taButtonViewModel = NgramButtonViewModel(firstChar: .ta)
fileprivate let koButtonViewModel = NgramButtonViewModel(firstChar: .ko)
fileprivate let oButtonViewModel = NgramButtonViewModel(firstChar: .o)
fileprivate let waButtonViewModel = NgramButtonViewModel(firstChar: .wa)
fileprivate let naButtonViewModel = NgramButtonViewModel(firstChar: .na)
fileprivate let aButtonViewModel = NgramButtonViewModel(firstChar: .a)

extension FirstChar {
  var buttonViewModel: NgramButtonViewModel {
    switch self {
    case .justOne: justOneButtonViewModel
    case .u:   uButtonViewModel
    case .tsu: tsuButtonViewModel
    case .shi: shiButtonViewModel
    case .mo:  moButtonViewModel
    case .yu:  yuButtonViewModel
    case .i:   iButtonViewModel
    case .chi: chiButtonViewModel
    case .hi:  hiButtonViewModel
    case .ki:  kiButtonViewModel
    case .ha:  haButtonViewModel
    case .ya:  yaButtonViewModel
    case .yo:  yoButtonViewModel
    case .ka:  kaButtonViewModel
    case .mi:  miButtonViewModel
    case .ta:  taButtonViewModel
    case .ko:  koButtonViewModel
    case .o:   oButtonViewModel
    case .wa:  waButtonViewModel
    case .na:  naButtonViewModel
    case .a:   aButtonViewModel
    }
  }
}
