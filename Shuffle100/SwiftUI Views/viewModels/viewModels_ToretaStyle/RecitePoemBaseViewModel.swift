//
//  RecitePoemBaseViewModel.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/09/24.
//

import Combine
import SwiftUI

final class RecitePoemBaseViewModel: ViewModelObject {

  final class Input: InputObject {
    let flipAnimation = PassthroughSubject<Void, Never>()
    let flipAnimationReverse = PassthroughSubject<Void, Never>()
    let slideAnimation = PassthroughSubject<CGFloat, Never>()
  }

  final class Binding: BindingObject {
    // Bindings can be added here if needed
  }

  final class Output: OutputObject {
    @Published var rotationAngle: Double = 0
    @Published var slideOffset: CGFloat = 0
    @Published var showingSlideCard: Bool = false
    @Published var currentViewIndex: Int = 0
    @Published var showGameEndView: Bool = false
  }

  let input: Input
  @BindableObject private(set) var binding: Binding
  let output: Output

  // Child ViewModel
  let recitePoemViewModel: RecitePoemViewModel

  // Settings
  internal let settings: Settings

  // Screen size for animations
  var screenWidth: CGFloat = 0

  // Actions set by Coordinator
  var playerFinishedAction: (() -> Void)?
  var playButtonTappedAfterFinishedReciting: (() -> Void)?
  var skipToNextScreenAction: (() -> Void)?

  internal var cancellables: Set<AnyCancellable> = []

  init(settings: Settings) {
    let input = Input()
    let binding = Binding()
    let output = Output()
    let recitePoemViewModel = RecitePoemViewModel(settings: settings)

    self.settings = settings
    self.input = input
    self.binding = binding
    self.output = output
    self.recitePoemViewModel = recitePoemViewModel

    setupBindings()
  }

  private func setupBindings() {
    // Forward actions from RecitePoemViewModel to Coordinator
    recitePoemViewModel.playerFinishedAction = { [weak self] in
      self?.playerFinishedAction?()
    }

    recitePoemViewModel.playButtonTappedAfterFinishedReciting = { [weak self] in
      self?.playButtonTappedAfterFinishedReciting?()
    }

    recitePoemViewModel.skipToNextScreenAction = { [weak self] in
      self?.skipToNextScreenAction?()
    }

    // フリップアニメーション処理
    input.flipAnimation
      .sink { [weak self] in
        guard let self = self else { return }
        self.output.rotationAngle += 180
        self.output.currentViewIndex += 1
      }
      .store(in: &cancellables)

    // 逆方向フリップアニメーション処理
    input.flipAnimationReverse
      .sink { [weak self] in
        guard let self = self else { return }
        self.output.rotationAngle -= 180
        self.output.currentViewIndex += 1
      }
      .store(in: &cancellables)

    // スライドアニメーション処理
    input.slideAnimation
      .sink { [weak self] screenWidth in
        guard let self = self else { return }
        self.output.showingSlideCard = true
        self.output.slideOffset = screenWidth

        withAnimation(.spring(response: Double(self.settings.kamiShimoInterval), dampingFraction: 1.0)) {
          self.output.slideOffset = 0
        }

        Task { @MainActor in
          try? await Task.sleep(nanoseconds: UInt64(self.settings.kamiShimoInterval * 1_000_000_000))
          self.output.currentViewIndex += 1
          self.output.showingSlideCard = false
        }
      }
      .store(in: &cancellables)
  }

  // MARK: - Public Methods

  func initView(title: String) {
    recitePoemViewModel.initView(title: title)
  }

  // MARK: - Screen Transition Methods

  func stepIntoNextPoem(number: Int, at counter: Int, total: Int, side: Side) {
    let sideStr = side == .kami ? "上" : "下"
    let newTitle = "\(counter)首め:" + sideStr + "の句 (全\(total)首)"
    recitePoemViewModel.output.title = newTitle

    // フリップアニメーションをトリガー
    input.flipAnimation.send()

    // アニメーション完了後に音声を再生
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.interval)) {
      if side == .kami {
        self.recitePoemViewModel.playNumberedPoem(number: number, side: .kami, count: counter)
      } else {
        self.recitePoemViewModel.playNumberedPoem(number: number, side: .shimo, count: counter)
      }
    }
  }

  func slideIntoShimo(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"
    recitePoemViewModel.output.title = newTitle

    // スライドインアニメーションをトリガー（画面幅を使用）
    if screenWidth > 0 {
      input.slideAnimation.send(screenWidth)
    }

    // アニメーション終了後に音声を再生
    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settings.kamiShimoInterval)) {
      self.recitePoemViewModel.playNumberedPoem(number: number, side: .shimo, count: counter)
    }
  }

  func slideBackToKami(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:上の句 (全\(total)首)"
    recitePoemViewModel.output.title = newTitle

    // スライドインアニメーションをトリガー（負の値で左から右へ）
    if screenWidth > 0 {
      input.slideAnimation.send(-screenWidth)
    }

    // 音声の自動再生は行わず、ユーザーがPlayButtonを押すのを待つ
  }

  func goBackToPrevPoem(number: Int, at counter: Int, total: Int) {
    let newTitle = "\(counter)首め:下の句 (全\(total)首)"
    recitePoemViewModel.output.title = newTitle

    // 逆方向フリップアニメーションをトリガー
    input.flipAnimationReverse.send()

    // 音声の自動再生は行わず、ユーザーがPlayButtonを押すのを待つ
  }

  func stepIntoGameEnd() {
    // タイトルを即座に更新
    recitePoemViewModel.output.title = "試合終了"

    // ゲーム終了画面フラグを即座にON（フリップアニメーション前に）
    output.showGameEndView = true

    // フリップアニメーションをトリガー
    input.flipAnimation.send()
  }

  func refrainShimo(number: Int, count: Int) {
    // タイトルは既に設定済みなので、音声を再生するだけ
    recitePoemViewModel.playNumberedPoem(number: number, side: .shimo, count: count)
  }

  // MARK: - Computed Properties

  var normalizedAngle: Double {
    output.rotationAngle.truncatingRemainder(dividingBy: 360)
  }

  var isFrontVisible: Bool {
    normalizedAngle < 180
  }

  var isNear90DegreesOrLess: Bool {
    let angle = normalizedAngle
    return angle < 90 || angle > 270
  }

  // MARK: - Cleanup

  deinit {
    cancellables.removeAll()
  }
}
