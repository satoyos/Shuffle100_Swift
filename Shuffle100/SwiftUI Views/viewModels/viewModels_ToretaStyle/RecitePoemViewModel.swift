//
//  RecitePoemViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/23.
//

import Combine
import AVFoundation
import SwiftUI

final class RecitePoemViewModel: NSObject, ViewModelObject, AVAudioPlayerDelegate {

  final class Input: InputObject {
    let gearButtonTapped = PassthroughSubject<Void, Never>()
    let exitButtonTapped = PassthroughSubject<Void, Never>()
    let rewindButtonTapped = PassthroughSubject<Void, Never>()
    let forwardButtonTapped = PassthroughSubject<Void, Never>()
    let audioPlayerFinished = PassthroughSubject<Void, Never>()
    let appWillResignActive = PassthroughSubject<Void, Never>()
  }

  final class Binding: BindingObject {
    @Published var progressValue: Float = 0.0
  }

  final class Output: OutputObject {
    @Published var title: String = "To be Filled!"
    @Published var showNormalJokaDesc: Bool = false
    @Published var showShortJokaDesc: Bool = false
    @Published var showExitAlert: Bool = false
    @Published var showPostMortemSheet: Bool = false
  }

  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output

  let playButtonViewModel: RecitePlayButton.ViewModel

  // Audio and Timer management
  internal var currentPlayer: AVAudioPlayer?
  internal var progressTimer: Timer?
  internal var playFinished: Bool = false

  // Settings and dependencies
  internal let settings: Settings
  internal let singer: Singer
  internal let audioPlayerFactory: AudioPlayerFactoryProtocol

  // Test support
  internal var isInTestMode: Bool = false

  // Actions
  var playerFinishedAction: (() -> Void)?
  var playButtonTappedAfterFinishedReciting: (() -> Void)?
  var backToPreviousAction: (() -> Void)?
  var skipToNextScreenAction: (() -> Void)?
  var openSettingsAction: (() -> Void)?
  var backToHomeScreenAction: (() -> Void)?
  var startPostMortemAction: (() -> Void)?

  internal var cancellables: Set<AnyCancellable> = []

  init(settings: Settings, audioPlayerFactory: AudioPlayerFactoryProtocol = AudioPlayerFactory.shared) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    let playButtonViewModel = RecitePlayButton.ViewModel(type: .play)

    self.settings = settings
    guard let singer = Singers.getSingerOfID(settings.singerID) else {
      fatalError("[\(settings.singerID)]に対応する読手が見つかりません。")
    }
    self.singer = singer
    self.audioPlayerFactory = audioPlayerFactory

    self.input = input
    self.binding = binding
    self.output = output
    self.playButtonViewModel = playButtonViewModel

    super.init()
    setupBindings()
  }



  // MARK: - Public Methods

  func initView(title: String) {
    output.title = title
  }







  // MARK: - Test Support

  func enableTestMode() {
    isInTestMode = true
  }

  var testCurrentPlayer: AVAudioPlayer? {
    return currentPlayer
  }

  // MARK: - Joka Description Management

  func addNormalJokaDescLabel() {
    output.showNormalJokaDesc = true
    output.showShortJokaDesc = false
  }

  func addShortJokaDescLabel() {
    output.showShortJokaDesc = true
    output.showNormalJokaDesc = false
  }

  func hideJokaDescLabels() {
    output.showNormalJokaDesc = false
    output.showShortJokaDesc = false
  }

  // MARK: - Play Button State Management

  func showAsWaitingForPlay() {
    if playButtonViewModel.output.type != .play {
      playButtonViewModel.input.showAsWaitingFor.send(.play)
    }
  }

  func showAsWaitingForPause() {
    if playButtonViewModel.output.type != .pause {
      playButtonViewModel.input.showAsWaitingFor.send(.pause)
    }
  }

  // MARK: - Cleanup

  deinit {
    progressTimer?.invalidate()
    currentPlayer?.stop()
    cancellables.removeAll()
  }
}