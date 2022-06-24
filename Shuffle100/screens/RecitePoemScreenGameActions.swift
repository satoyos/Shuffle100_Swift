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
        recitePoemView.progressView.setProgress(Float(player.currentTime / player.duration), animated: false)
    }
    
    func stepIntoNextPoem(number: Int, at counter: Int, total: Int) {
        UIView.transition(with: self.view, duration: interval(), options: [.transitionFlipFromLeft, .layoutSubviews], animations: {
            let newReciteView = RecitePoemView()
            self.recitePoemView.removeFromSuperview()
            UIView.performWithoutAnimation {
                self.view.addSubview(newReciteView)
                newReciteView.initView(title: "\(counter)首め:上の句 (全\(total)首)")
            }
            self.recitePoemView = newReciteView
            self.addActionsToButtons()
        }, completion: { finished in
            self.reciteKami(number: number, count: counter)
        })
    }
    
    func waitUserActionAfterFineshdReciing() {
        recitePoemView.showAsWaitingFor(.play)
    }
    
    private func setUpNewScreen(with newReciteView: RecitePoemView) {
        self.recitePoemView.removeFromSuperview()
        self.recitePoemView = newReciteView
        self.addActionsToButtons()
    }
    
    func slideIntoShimo(number: Int, at counter: Int, total: Int) {
        let newReciteView = RecitePoemView()
        view.addSubview(newReciteView)
        newReciteView.initView(title: "\(counter)首め:下の句 (全\(total)首)")
        newReciteView.fixLayoutOn(baseView: self.view, offsetX: self.view.frame.width)
        
        UIView.animate(withDuration: kamiShimoInterval(), animations: {
            newReciteView.fixLayoutOn(baseView: self.view, offsetX: 0)
        }, completion: { finished in
            self.setUpNewScreen(with: newReciteView)
            self.reciteShimo(number: number, count: counter)
        })
    }
    
    func slideBackToKami(number: Int, at counter: Int, total: Int) {
        let newReciteView = RecitePoemView()
        view.addSubview(newReciteView)
        newReciteView.initView(title: "\(counter)首め:上の句 (全\(total)首)")
        newReciteView.fixLayoutOn(baseView: self.view, offsetX: -1 * self.view.frame.width)
        
        UIView.animate(withDuration: kamiShimoInterval(), animations: {
            newReciteView.fixLayoutOn(baseView: self.view, offsetX: 0)
        }, completion: { finished in
            self.setUpNewScreen(with: newReciteView)
            self.reciteKami(number: number, count: counter)
            self.playButtonTapped()
        })
    }
    
    func goBackToPrevPoem(number: Int, at counter: Int, total: Int) {
        UIView.transition(with: self.view, duration: interval(), options: [.transitionFlipFromRight, .layoutSubviews], animations: {
            let newReciteView = RecitePoemView()
            self.recitePoemView.removeFromSuperview()
            UIView.performWithoutAnimation {
                self.view.addSubview(newReciteView)
                newReciteView.initView(title: "\(counter)首め:下の句 (全\(total)首)")
            }
            self.recitePoemView = newReciteView
            self.addActionsToButtons()
        }, completion: { finished in
            self.reciteShimo(number: number, count: counter)
            self.playButtonTapped()
        })
    }
    
    func stepIntoGameEnd() {
        UIView.transition(with: self.view, duration: interval(), options: [.transitionFlipFromLeft, .layoutSubviews], animations: {
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
        }, completion: nil)
    }
    
    func refrainShimo(number: Int, count: Int) {
        self.reciteShimo(number: number, count: count)
    }
    
    private func reciteKami(number: Int, count: Int) {
        playNumberedPoem(number: number, side: .kami, count: count)
    }
    
    private func reciteShimo(number: Int, count: Int) {
        playNumberedPoem(number: number, side: .shimo, count: count)
    }
    
    private func interval() -> Double {
        return Double(settings.interval)
    }
    
    private func kamiShimoInterval() -> Double {
        return Double(settings.kamiShimoInterval)
    }
}
