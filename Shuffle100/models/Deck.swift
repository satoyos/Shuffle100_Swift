//
//  Deck.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/22.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

class Deck {
    static let originalPoems = Poem100.poems
    var poems: [Poem]
    private var count = 0
    
    init(poems: [Poem]) {
        self.poems = poems
    }
    
    convenience init() {
        self.init(poems: Deck.originalPoems)
    }
    
    static func createFrom(state100: SelectedState100) -> Deck {
        var resultPoems: [Poem]
        resultPoems = []
        for i in 0..<100 {
            if state100.bools[i] {
                resultPoems.append(originalPoems[i])
            }
        }
        let deck = Deck()
        deck.poems = resultPoems
        return deck
    }
    
    var size: Int {
        get {
            return poems.count
        }
    }
    
    var counter: Int {
        get {
            return self.count
        }
    }
    
    func nextPoem() -> Poem? {
        if count == poems.count {
            return nil
        } else {
            count+=1
            return poems[count-1]
        }
    }
    
    func rollBackPoem() -> Poem? {
        switch count {
        case 0:
            return nil
        case 1:
            count = 0
            return nil
        default:
            count -= 1
            return poems[count-1]
        }
    }
    
    func shuffleWithSize(size: Int) {
        let shuffledPoems = poems.shuffled()
        poems = []
        for i in 0..<size {
            poems.append(shuffledPoems[i])
        }
        
    }
    
    func shuffle() {
        shuffleWithSize(size: poems.count)
    }
    
    func addFakePoems() {
        if self.size >= 50 {
            poems = Deck.originalPoems
            return
        }
        let selectedNums = poems.map{$0.number}
        let int100 = (Array<Int>)(1...100)
        let restNums = int100.diff(selectedNums).shuffled()
        for i in 0..<selectedNums.count {
            poems.append(Deck.originalPoems[restNums[i]-1])
        }
    }
}
