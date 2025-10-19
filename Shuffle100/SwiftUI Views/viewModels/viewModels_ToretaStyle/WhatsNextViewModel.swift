//
//  WhatsNextViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/10/19.
//

import Combine

final class WhatsNextViewModel: ViewModelObject {

  final class Input: InputObject {
    let torifudaButtonTapped = PassthroughSubject<Void, Never>()
    let refrainButtonTapped = PassthroughSubject<Void, Never>()
    let goNextButtonTapped = PassthroughSubject<Void, Never>()
    let gearButtonTapped = PassthroughSubject<Void, Never>()
    let exitButtonTapped = PassthroughSubject<Void, Never>()
  }

  final class Binding: BindingObject {
    @Published var showExitConfirmation = false
  }

  final class Output: OutputObject {
    @Published var currentPoem: Poem

    init(currentPoem: Poem) {
      self.currentPoem = currentPoem
    }
  }

  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output
  private var cancellables: Set<AnyCancellable> = []

  // アクションクロージャ
  var showTorifudaAction: (() -> Void)?
  var refrainAction: (() -> Void)?
  var goNextAction: (() -> Void)?
  var goSettingAction: (() -> Void)?
  var backToHomeScreenAction: (() -> Void)?

  init(currentPoem: Poem) {
    let input = Input()
    let binding = Binding()
    let output = Output(currentPoem: currentPoem)

    self.input = input
    self.binding = binding
    self.output = output

    // ボタンタップのハンドリング
    input.torifudaButtonTapped
      .sink { [weak self] in
        self?.showTorifudaAction?()
      }
      .store(in: &cancellables)

    input.refrainButtonTapped
      .sink { [weak self] in
        self?.refrainAction?()
      }
      .store(in: &cancellables)

    input.goNextButtonTapped
      .sink { [weak self] in
        self?.goNextAction?()
      }
      .store(in: &cancellables)

    input.gearButtonTapped
      .sink { [weak self] in
        self?.goSettingAction?()
      }
      .store(in: &cancellables)

    input.exitButtonTapped
      .sink { [weak self] in
        self?.binding.showExitConfirmation = true
      }
      .store(in: &cancellables)
  }
}
