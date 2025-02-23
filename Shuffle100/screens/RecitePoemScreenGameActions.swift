//
//  RecitePoemScreenGameActions.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2019/11/24.
//  Copyright © 2019 里 佳史. All rights reserved.
//

import UIKit
import AVFoundation

extension RecitePoemScreen {
  
  @objc func updateAudioProgressView() {
    guard let player = currentPlayer else { return }
    recitePoemView.progressView
      .setProgress(
        Float(player.currentTime / player.duration),
        animated: false
      )
  }
  
  func stepIntoNextPoem(number: Int, at counter: Int, total: Int) {
    if settings.reciteMode == .hokkaido {
      UIView.transition(
        with: self.view,
        duration: interval,
        options: [.transitionFlipFromLeft, .layoutSubviews],
        animations: stepIntoNextPoemAnimation(          with: titleStr(of: counter, side: .shimo, in: total)),
        completion: { _ in
          self.reciteShimo(number: number, count: counter)
        }
      )
    } else {
      UIView.transition(
        with: self.view,
        duration: interval,
        options: [.transitionFlipFromLeft, .layoutSubviews],
        animations: stepIntoNextPoemAnimation(          with: titleStr(of: counter, side: .kami, in: total)),
        completion: { _ in
          self.reciteKami(number: number, count: counter)
        }
      )
    }
  }
  
  private func titleStr(of counter: Int, side: Side, in total: Int) -> String {
    let sideStr = side == .kami ? "上" : "下"
    return "\(counter)首め:" + sideStr + "の句 (全\(total)首)"
  }
  
  private func stepIntoNextPoemAnimation(with title: String) ->  () -> Void {
    {
      let newReciteView = RecitePoemView()
      self.recitePoemView.removeFromSuperview()
      UIView.performWithoutAnimation {
        self.view.addSubview(newReciteView)
        newReciteView.initView(title: title)
      }
      self.recitePoemView = newReciteView
      self.addActionsToButtons()
    }
  }
  
  func waitUserActionAfterFineshdReciing() {
    recitePoemView.showAsWaitingFor(.play)
  }
  
  private func setUpNewScreen(with newReciteView: RecitePoemView) {
    recitePoemView.removeFromSuperview()
    self.recitePoemView = newReciteView
    addActionsToButtons()
  }
  
  func slideIntoShimo(number: Int, at counter: Int, total: Int) {
    let newReciteView = RecitePoemView()
    view.addSubview(newReciteView)
    newReciteView.initView(title: titleStr(of: counter, side: .shimo, in: total))
    newReciteView.fixLayoutOn(baseView: self.view, offsetX: self.view.frame.width)
    
    UIView.animate(
      withDuration: kamiShimoInterval,
      animations: {
        newReciteView.fixLayoutOn(baseView: self.view, offsetX: 0)
      },
      completion: { _ in
        self.setUpNewScreen(with: newReciteView)
        self.reciteShimo(number: number, count: counter)
      }
    )
  }
  
  func slideBackToKami(number: Int, at counter: Int, total: Int) {
    let newReciteView = RecitePoemView()
    view.addSubview(newReciteView)
    newReciteView.initView(title: titleStr(of: counter, side: .kami, in: total))
    newReciteView.fixLayoutOn(baseView: self.view, offsetX: -1 * self.view.frame.width)
    
    UIView.animate(
      withDuration: kamiShimoInterval,
      animations: {
        newReciteView.fixLayoutOn(baseView: self.view, offsetX: 0)
      },
      completion: { _ in
        self.setUpNewScreen(with: newReciteView)
        self.reciteKami(number: number, count: counter)
        self.playButtonTapped()
      }
    )
  }
  
  func goBackToPrevPoem(number: Int, at counter: Int, total: Int) {
    UIView.transition(
      with: view,
      duration: interval,
      options: [.transitionFlipFromRight, .layoutSubviews],
      animations: {
        let newReciteView = RecitePoemView()
        self.recitePoemView.removeFromSuperview()
        UIView.performWithoutAnimation {
          self.view.addSubview(newReciteView)
          newReciteView.initView(title: self.titleStr(of: counter, side: .shimo, in: total))
        }
        self.recitePoemView = newReciteView
        self.addActionsToButtons()
      }, completion: { _ in
        self.reciteShimo(number: number, count: counter)
        self.playButtonTapped()
      }
    )
  }
  
  func stepIntoGameEnd() {
    UIView.transition(
      with: view,
      duration: interval,
      options: [.transitionFlipFromLeft, .layoutSubviews],
      animations: {
        var allPoemsRecitedView: AllPoemsRecitedView
        
        if self.settings.postMortemEnabled {
          allPoemsRecitedView = PostMortemEnabledGameEndView().then {
            $0.backToHomeButtonAction = { [weak self] in
              self?.backToHomeScreenAction?()
            }
            $0.gotoPostMortemAction = { [weak self] in
              self?.confirmStartingPostMortem()
            }
          }
        } else {
          allPoemsRecitedView = SimpleGameEndView().then {
            $0.backToHomeButtonAction = { [weak self] in
              self?.backToHomeScreenAction?()
            }
          }
        }
        
        self.recitePoemView.removeFromSuperview()
        UIView.performWithoutAnimation {
          self.view.addSubview(allPoemsRecitedView as! UIView)
          allPoemsRecitedView.initView(title: "試合終了")
          allPoemsRecitedView.fixLayoutOn(baseView: self.view)
        }
        self.gameEndView = allPoemsRecitedView
        self.recitePoemView = nil
        self.currentPlayer = nil
      }, completion: nil
    )
  }
  
  func refrainShimo(number: Int, count: Int) {
    reciteShimo(number: number, count: count)
  }
  
  private func reciteKami(number: Int, count: Int) {
    playNumberedPoem(number: number, side: .kami, count: count)
  }
  
  private func reciteShimo(number: Int, count: Int) {
    playNumberedPoem(number: number, side: .shimo, count: count)
  }
  
  private var interval: Double {
    Double(settings.interval)
  }
  
  private var kamiShimoInterval: Double {
    Double(settings.kamiShimoInterval)
  }
}
