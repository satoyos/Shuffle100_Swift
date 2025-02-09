//
//  VolumeSettingViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/18.
//

import Combine

final class VolumeSettingViewModel: ViewModelObject {
  final class Input: InputObject {
    let startTestRecitingRequest = PassthroughSubject<Void, Never>()
  }
  
  final class Output: OutputObject {
    @Published fileprivate(set) var ratioText = "0"
    @Published fileprivate(set) var isButtonDisabled = false
  }
  
  final class Binding: BindingObject {
    @Published var volume: Double = 0.0
  }
  
  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output
  private let audioHandler: ReciteSettingAudioHandler

  private var cancellables: Set<AnyCancellable> = []
  
  init(volume: Double, singer: Singer) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    let audioHandler = ReciteSettingAudioHandler(
      halfPoem1: .h001a, halfPoem2: .h001b, folderPath: singer.path
    )
    
    
    binding.volume = volume
    
    binding.$volume
      .map { Self.percentStrOf(ratio: $0) }
      .assign(to: \.ratioText, on: output)
      .store(in: &cancellables)
    
    binding.$volume
      .sink { vol in
        audioHandler.player1.volume = Float(vol)
      }
      .store(in: &cancellables)
    
    input.startTestRecitingRequest
      .sink { _ in
        output.isButtonDisabled = true
        audioHandler.player1FinishedAction = {
          output.isButtonDisabled = false
        }
        audioHandler.startPlayer1()
      }
      .store(in: &cancellables)
    
    self.input = input
    self.binding = binding
    self.output = output
    self.audioHandler = audioHandler
  }
  
  private static func percentStrOf(ratio: Double) -> String {
      String(format: "% 3d", Int(ratio * 100))
  }
}

extension VolumeSettingViewModel {
  func stopReciting() {
    audioHandler.stopAllPlayers()
  }
}
