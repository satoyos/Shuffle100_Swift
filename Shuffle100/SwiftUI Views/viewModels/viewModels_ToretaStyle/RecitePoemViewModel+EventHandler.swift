//
//  RecitePoemViewModel+EventHandler.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/24.
//

import Combine

extension RecitePoemViewModel {

  // MARK: - Bindings Setup

  internal func setupBindings() {
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

  // MARK: - Event Handlers

  internal func handleGearButtonTapped() {
    if let player = currentPlayer, player.isPlaying {
      pauseCurrentPlayer()
    }
    openSettingsAction?()
  }

  internal func handleExitButtonTapped() {
    if settings.postMortemEnabled {
      // Handle post mortem selection
      // This would typically show an alert, but we'll delegate to the action
      backToHomeScreenAction?()
    } else {
      backToHomeScreenAction?()
    }
  }

  internal func handleRewindButtonTapped() {
    guard let player = currentPlayer else {
      if isInTestMode {
        backToPreviousAction?()
      }
      return
    }
    if player.currentTime > 0.0 {
      player.currentTime = 0.0
      pauseCurrentPlayer()
      updateAudioProgressView()
    } else {
      backToPreviousAction?()
    }
  }

  internal func handleForwardButtonTapped() {
    guard let player = currentPlayer else {
      if isInTestMode {
        skipToNextScreenAction?()
      }
      return
    }
    player.stop()
    skipToNextScreenAction?()
  }

  internal func handleAudioPlayerFinished() {
    guard currentPlayer != nil else {
      if isInTestMode {
        binding.progressValue = 1.0
        playFinished = true
        playerFinishedAction?()
      }
      return
    }
    binding.progressValue = 1.0
    playFinished = true
    playerFinishedAction?()
  }

  internal func handleAppWillResignActive() {
    progressTimer?.invalidate()
    if let player = currentPlayer, player.isPlaying {
      player.stop()
    }
  }

  internal func handlePlayButtonStateChange() {
    if playFinished {
      playButtonTappedAfterFinishedReciting?()
    } else {
      flipPlaying()
    }
  }
}