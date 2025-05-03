//
//  FiveColorsViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/04/19.
//

import Combine

fileprivate let blueButtonViewModel = FiveColorButtonViewModel(color: .blue)
fileprivate let yellowButtonViewModel = FiveColorButtonViewModel(color: .yellow)
fileprivate let pinButtonViewModel = FiveColorButtonViewModel(color: .pink)
fileprivate let greenButtonViewModel = FiveColorButtonViewModel(color: .green)
fileprivate let orangeButtonViewModel = FiveColorButtonViewModel(color: .orange)

final class FiveColorsViewModel: ViewModelObject, FillTypeHandlable {

  final class Input: InputObject {
    let colorButtonTapped = PassthroughSubject<FiveColors, Never>()
    let selectJust20OfColor = PassthroughSubject<FiveColors, Never>()
    let add20OfColor = PassthroughSubject<FiveColors, Never>()
  }
  
  final class Binding: BindingObject {
  }
  
  final class Output: OutputObject {
    @Published var state100: SelectedState100 = .init()
  }
  
  let input: Input
  @BindableObject private(set) var binding:  Binding
  let output: Output
  var cancellables: Set<AnyCancellable> = []
    
  init(state100: SelectedState100) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    
    output.state100 = state100
    
    FiveColors.all.forEach { color in
      let fillType = Self.fillType(of: color, for: state100)
      color.buttonViewModel.input.setFillType.send(fillType)
    }
    
    input.selectJust20OfColor
      .sink{ color in
        let newState100 = SelectedState100()
          .cancelAll()
          .selectInNumbers(color.poemNumbers)
        output.state100 = newState100
      }
      .store(in: &cancellables)
    
    input.add20OfColor
      .sink { color in
        let newState100 = output.state100
          .selectInNumbers(color.poemNumbers)
        output.state100 = newState100
      }
      .store(in: &cancellables)
    
    output.$state100
      .sink { st100 in
        FiveColors.all.forEach { color in
          let fillType = Self.fillType(of: color, for: st100)
          color.buttonViewModel.input.setFillType.send(fillType)
        }
      }
      .store(in: &cancellables)
    
    self.input = input
    self.binding = binding
    self.output = output
  }
}

extension FiveColorsViewModel {
  static func fillType(of color: FiveColors, for state100: SelectedState100) -> FillType {
    fillType(of: state100.allSelectedNumbers,
             in: color.poemNumbers)
  }
}

extension FiveColors {
  var buttonViewModel: FiveColorButtonViewModel {
    switch self {
    case .blue:   blueButtonViewModel
    case .yellow: yellowButtonViewModel
    case .pink:   pinButtonViewModel
    case .green:  greenButtonViewModel
    case .orange: orangeButtonViewModel
    }
  }
}
