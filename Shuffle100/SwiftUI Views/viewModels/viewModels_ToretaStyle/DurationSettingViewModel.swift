//
//  DurationSettingViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/12.
//

import Combine

final class DurationSettingViewModel: ViewModelObject {
    final class Input: InputObject {
        let startTimerRequest = PassthroughSubject<Void, Never>()
        let startTrialCountDownRequest = PassthroughSubject<Void, Never>()
    }
    
    final class Binding: BindingObject {
        // セットするDuration
        @Published var startTime: Double = 0.0
    }
    
    final class Output: OutputObject {
        @Published fileprivate(set) var secText: String = ""
        @Published fileprivate(set) var isTimerRunning = false
        @Published fileprivate(set) var isUserActionDisabled = false
    }
    
    let input: Input
    @BindableObject private(set) var binding: Binding
    let output: Output
    private(set) var timeViewModel: Sec2FViewModel
    private let audioHandler: DurationSettingAudioHandler
    private var cancellables: Set<AnyCancellable> = []
    
    init(durationType: DurationSettingType,
         startTime: Double,
         singer: Singer = Singers.defaultSinger) {
        let input = Input()
        let binding = Binding()
        let output = Output()
        let timeViewModel = Sec2FViewModel(startTime: startTime, interval: 0.02)
        let (halfPoem1, halfPoem2) = durationType.halfPoems
        let audioHandler = DurationSettingAudioHandler(
                halfPoem1: halfPoem1,
                halfPoem2: halfPoem2,
                folderPath: singer.path)
        
        binding.startTime = startTime
        
        timeViewModel.output.$secText
            .assign(to: \.secText, on: output)
            .store(in: &cancellables)
        
        timeViewModel.output.$isTimerRunning
            .assign(to: \.isTimerRunning, on: output)
            .store(in: &cancellables)
        
        input.startTimerRequest
            .sink { _ in
                timeViewModel.input.startTimerRequest.send()
            }
            .store(in: &cancellables)
        
        input.startTrialCountDownRequest
            .sink { _ in
                output.isUserActionDisabled = true
                audioHandler.player1FinishedAction = { 
                    timeViewModel.input.startTimerRequest.send()
                }
                audioHandler.startPlayer1()
            }
            .store(in: &cancellables)
        
        output.$isTimerRunning
            .dropFirst() // Drop First "false"
            .filter { $0 == false }
            .sink { _ in
                audioHandler.player2FinishedAction = {
                    timeViewModel.input.resetTimerRequest.send(binding.startTime)                    
                    output.isUserActionDisabled = false
                }
                audioHandler.startPlayer2()
            }
            .store(in: &cancellables)
        
        binding.$startTime
            .dropFirst()
            .sink { time in
                timeViewModel.input.resetTimerRequest.send(time)
            }
            .store(in: &cancellables)
        
        self.input = input
        self.binding = binding
        self.output = output
        self.timeViewModel = timeViewModel
        self.audioHandler = audioHandler

    }
}
