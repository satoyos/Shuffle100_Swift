//
//  RecitePoemViewModel+Animation.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/24.
//

import SwiftUI

extension RecitePoemViewModel {

  // MARK: - Screen Transition Methods

  func stepIntoNextPoem(number: Int, at counter: Int, total: Int, side: Side) {
    let sideStr = side == .kami ? "上" : "下"
    let newTitle = "\(counter)首め:" + sideStr + "の句 (全\(total)首)"

    output.animationType = .flipFromLeft
    output.animationInProgress = true

    withAnimation(.easeInOut(duration: Double(settings.interval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.interval)) {
      self.output.animationInProgress = false
      if side == .kami {
        self.playNumberedPoem(number: number, side: .kami)
      } else {
        self.playNumberedPoem(number: number, side: .shimo)
      }
    }
  }

  func slideIntoShimo(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"

    output.animationType = .slideInFromRight
    output.animationInProgress = true

    withAnimation(.easeInOut(duration: Double(settings.kamiShimoInterval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.kamiShimoInterval)) {
      self.output.animationInProgress = false
      self.playNumberedPoem(number: number, side: .shimo)
    }
  }

  func slideBackToKami(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:上の句 (全\(total)首)"

    output.animationType = .slideInFromLeft
    output.animationInProgress = true

    withAnimation(.easeInOut(duration: Double(settings.kamiShimoInterval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.kamiShimoInterval)) {
      self.output.animationInProgress = false
      self.playNumberedPoem(number: number, side: .kami)
      // Auto-play after rewinding
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.handlePlayButtonTapped()
      }
    }
  }

  func goBackToPrevPoem(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"

    output.animationType = .flipFromRight
    output.animationInProgress = true

    withAnimation(.easeInOut(duration: Double(settings.interval))) {
      output.title = newTitle
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.interval)) {
      self.output.animationInProgress = false
      self.playNumberedPoem(number: number, side: .shimo)
      // Auto-play after going back
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        self.handlePlayButtonTapped()
      }
    }
  }

  func stepIntoGameEnd() {
    output.animationType = .flipFromLeft
    output.animationInProgress = true

    withAnimation(.easeInOut(duration: Double(settings.interval))) {
      output.title = "試合終了"
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.interval)) {
      self.output.animationInProgress = false
    }

    // TODO: Show game end view - this would require additional state management
    // For now, we'll just update the title
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
}
