//
//  RecitePlayButton.ViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/07/23.
//

import Combine

extension RecitePlayButton {
  final class ViewModel: ViewModelObject {

    final class Input: InputObject {
      let playButtonTapped = PassthroughSubject<Void, Never>()
      let showAsWaitingFor = PassthroughSubject<ReciteViewGeneralButton.LabelType, Never>()
    }

    final class Binding: BindingObject {
    }

    final class Output: OutputObject {
      @Published var type: ReciteViewGeneralButton.LabelType
      @Published var isWaitingForPlay: Bool
      let playButtonTapped = PassthroughSubject<Void, Never>()

      init(type: ReciteViewGeneralButton.LabelType = .play) {
        self.type = type
        self.isWaitingForPlay = type == .play ? true : false
      }
    }

    let input: Input
    @BindableObject private(set) var binding: Binding
    let output: Output

    private var cancellables: Set<AnyCancellable> = []

    init(type: ReciteViewGeneralButton.LabelType = .play) {
      let input = Input()
      let binding = Binding()
      let output = Output(type: type)

      input.playButtonTapped
        .sink { _ in
          output.isWaitingForPlay.toggle()
          output.type = output.isWaitingForPlay ? .play : .pause
          output.playButtonTapped.send()
        }
        .store(in: &cancellables)
      
      input.showAsWaitingFor
        .sink { [weak output] newType in
          output?.type = newType
          output?.isWaitingForPlay = (newType == .play)
        }
        .store(in: &cancellables)

      self.input = input
      self.binding = binding
      self.output = output
    }

//    func playButtonTapped() {
//      input.playButtonTapped.send()
//    }
  }
}
