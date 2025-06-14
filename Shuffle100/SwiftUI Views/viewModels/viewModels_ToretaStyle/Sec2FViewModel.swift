//
//  Sec2FViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2024/11/09.
//

import Combine

final class Sec2FViewModel: ViewModelObject {
  
  final class Input: InputObject {
    let startTimerRequest = PassthroughSubject<Void, Never>()
    //        let stopTimerRequest = PassthroughSubject<Void, Never>()
    let resetTimerRequest = PassthroughSubject<Double, Never>()
  }
  
  final class Binding: BindingObject { }
  
  final class Output: OutputObject {
    @Published fileprivate(set) var secText = ""
    
    @Published fileprivate(set) var isTimerRunning = false
  }
  
  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output
  private(set) var startTime: Double
  //    private let interval: Double
  private var timer: CountDownTimer
  
  private var cancellables = Set<AnyCancellable>()
  
  init(startTime: Double, interval: Double) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    let timer = CountDownTimer(startTime: startTime, interval: interval)
    output.secText = Self.strOf(time: startTime)
    
    timer.$remainTime
      .map(Self.strOf)
      .assign(to: \.secText, on: output)
      .store(in: &cancellables)
    
    timer.$isRunning
      .assign(to: \.isTimerRunning, on: output)
      .store(in: &cancellables)
    
    input.startTimerRequest
      .sink { _ in
        timer.start()
      }
      .store(in: &cancellables)
    
    input.resetTimerRequest
      .sink { newTime in
        timer.reset(to: newTime)
      }
      .store(in: &cancellables)
    
    
    self.input = input
    self.binding = binding
    self.output = output
    self.timer = timer
    self.startTime = startTime
    //        self.interval = interval
    
  }
  
  private static func strOf(time: Double) -> String {
    String(format: "%.2F", time)
  }
  
}
