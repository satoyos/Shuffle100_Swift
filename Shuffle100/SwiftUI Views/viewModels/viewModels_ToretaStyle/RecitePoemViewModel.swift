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
  }

  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output

  let playButtonViewModel: RecitePlayButton.ViewModel

  // Audio and Timer management
  private var currentPlayer: AVAudioPlayer?
  private var progressTimer: Timer?
  private var playFinished: Bool = false

  // Settings and dependencies
  private let settings: Settings
  private let singer: Singer

  // Actions
  var playerFinishedAction: (() -> Void)?
  var playButtonTappedAfterFinishedReciting: (() -> Void)?
  var backToPreviousAction: (() -> Void)?
  var skipToNextScreenAction: (() -> Void)?
  var openSettingsAction: (() -> Void)?
  var backToHomeScreenAction: (() -> Void)?

  private var cancellables: Set<AnyCancellable> = []

  init(settings: Settings) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    let playButtonViewModel = RecitePlayButton.ViewModel(type: .play)

    self.settings = settings
    guard let singer = Singers.getSingerOfID(settings.singerID) else {
      fatalError("[\(settings.singerID)]に対応する読手が見つかりません。")
    }
    self.singer = singer

    self.input = input
    self.binding = binding
    self.output = output
    self.playButtonViewModel = playButtonViewModel

    super.init()
    setupBindings()
  }

  private func setupBindings() {
    // Gear button handling
    input.gearButtonTapped
      .sink { [weak self] in
        self?.handleGearButtonTapped()
      }
      .store(in: &cancellables)

    // Exit button handling
    input.exitButtonTapped
      .sink { [weak self] in
        self?.handleExitButtonTapped()
      }
      .store(in: &cancellables)

    // Rewind button handling
    input.rewindButtonTapped
      .sink { [weak self] in
        self?.handleRewindButtonTapped()
      }
      .store(in: &cancellables)

    // Forward button handling
    input.forwardButtonTapped
      .sink { [weak self] in
        self?.handleForwardButtonTapped()
      }
      .store(in: &cancellables)

    // Audio player finished handling
    input.audioPlayerFinished
      .sink { [weak self] in
        self?.handleAudioPlayerFinished()
      }
      .store(in: &cancellables)

    // App will resign active handling
    input.appWillResignActive
      .sink { [weak self] in
        self?.handleAppWillResignActive()
      }
      .store(in: &cancellables)

    // Play button tap handling
    playButtonViewModel.objectWillChange
      .sink { [weak self] in
        self?.handlePlayButtonStateChange()
      }
      .store(in: &cancellables)
  }

  // MARK: - Public Methods

  func initView(title: String) {
    output.title = title
  }

  func stepIntoNextPoem(number: Int, at counter: Int, total: Int, side: Side) {
    let sideStr = side == .kami ? "上" : "下"
    let newTitle = "\(counter)首め:" + sideStr + "の句 (全\(total)首)"

    withAnimation(.easeInOut(duration: 0.5)) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      if side == .kami {
        self.playNumberedPoem(number: number, side: .kami)
      } else {
        self.playNumberedPoem(number: number, side: .shimo)
      }
    }
  }

  func slideIntoShimo(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"

    withAnimation(.easeInOut(duration: Double(settings.kamiShimoInterval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.kamiShimoInterval)) {
      self.playNumberedPoem(number: number, side: .shimo)
    }
  }

  func slideBackToKami(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:上の句 (全\(total)首)"

    withAnimation(.easeInOut(duration: Double(settings.kamiShimoInterval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.kamiShimoInterval)) {
      self.playNumberedPoem(number: number, side: .kami)
      // Auto-play after rewinding
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.handlePlayButtonStateChange()
      }
    }
  }

  func goBackToPrevPoem(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"

    withAnimation(.easeInOut(duration: 0.5)) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.playNumberedPoem(number: number, side: .shimo)
      // Auto-play after going back
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.handlePlayButtonStateChange()
      }
    }
  }

  func stepIntoGameEnd() {
    withAnimation(.easeInOut(duration: 0.5)) {
      output.title = "試合終了"
    }

    // TODO: Show game end view - this would require additional state management
    // For now, we'll just update the title
  }

  func showAsWaitingForPlay() {
    if playButtonViewModel.type != .play {
      playButtonViewModel.playButtonTapped()
    }
  }

  func showAsWaitingForPause() {
    if playButtonViewModel.type != .pause {
      playButtonViewModel.playButtonTapped()
    }
  }

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

  // MARK: - Audio Methods

  func playJoka(shorten: Bool = false) {
    currentPlayer = AudioPlayerFactory.shared.prepareOpeningPlayer(folder: singer.path)
    guard let player = currentPlayer else {
      print("序歌の音声ファイルが見つかりません。フォルダ[\(singer.path)]")
      return
    }

    if shorten {
      player.currentTime = Double(singer.shortenJokaStartTime)
      addShortJokaDescLabel()
    } else {
      addNormalJokaDescLabel()
    }

    startPlayingCurrentPlayer()
  }

  func playNumberedPoem(number: Int, side: Side) {
    currentPlayer = AudioPlayerFactory.shared.preparePlayer(number: number, side: side, folder: singer.path)
    guard currentPlayer != nil else {
      print("音声ファイルが見つかりません。歌番号[\(number)], フォルダ[\(singer.path)]")
      return
    }

    hideJokaDescLabels()
    startPlayingCurrentPlayer()
  }

  private func startPlayingCurrentPlayer() {
    prepareCurrentPlayer()
    playCurrentPlayer()
    setTimerForProgressView()
  }

  private func prepareCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.prepareToPlay()
    player.volume = settings.volume
    player.delegate = self
    playFinished = false
  }

  // MARK: - AVAudioPlayerDelegate

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    binding.progressValue = 1.0
    playFinished = true
    input.audioPlayerFinished.send()
  }

  private func playCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.play()
    showAsWaitingForPause()
  }

  private func pauseCurrentPlayer() {
    guard let player = currentPlayer else { return }
    player.pause()
    showAsWaitingForPlay()
  }

  private func setTimerForProgressView() {
    progressTimer?.invalidate()
    progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
      self?.updateAudioProgressView()
    }
  }

  @objc private func updateAudioProgressView() {
    guard let player = currentPlayer else { return }
    binding.progressValue = Float(player.currentTime / player.duration)
  }

  // MARK: - Event Handlers

  private func handleGearButtonTapped() {
    if let player = currentPlayer, player.isPlaying {
      pauseCurrentPlayer()
    }
    openSettingsAction?()
  }

  private func handleExitButtonTapped() {
    if settings.postMortemEnabled {
      // Handle post mortem selection
      // This would typically show an alert, but we'll delegate to the action
      backToHomeScreenAction?()
    } else {
      backToHomeScreenAction?()
    }
  }

  private func handleRewindButtonTapped() {
    guard let player = currentPlayer else { return }
    if player.currentTime > 0.0 {
      player.currentTime = 0.0
      pauseCurrentPlayer()
      updateAudioProgressView()
    } else {
      backToPreviousAction?()
    }
  }

  private func handleForwardButtonTapped() {
    guard let player = currentPlayer else { return }
    player.stop()
    skipToNextScreenAction?()
  }

  private func handleAudioPlayerFinished() {
    guard currentPlayer != nil else { return }
    binding.progressValue = 1.0
    playFinished = true
    playerFinishedAction?()
  }

  private func handleAppWillResignActive() {
    progressTimer?.invalidate()
    if let player = currentPlayer, player.isPlaying {
      player.stop()
    }
  }

  private func handlePlayButtonStateChange() {
    if playFinished {
      playButtonTappedAfterFinishedReciting?()
    } else {
      flipPlaying()
    }
  }

  private func flipPlaying() {
    guard let player = currentPlayer else { return }
    if player.isPlaying {
      pauseCurrentPlayer()
    } else {
      playCurrentPlayer()
    }
  }

  // MARK: - Cleanup

  deinit {
    progressTimer?.invalidate()
    currentPlayer?.stop()
    cancellables.removeAll()
  }
}