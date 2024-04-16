//
//  PoemSupplier.swift
//  Poems
//
//  Created by 里 佳史 on 2017/05/17.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

enum Side {
    case kami, shimo
}

//fileprivate let originalPoems = Poem100.originalPoems

class PoemSupplier {
    private var deck: [Poem]
    private var numberOfPoemsDrawn: Int = 0
    private var fuda_side: Side?
    private var mustShuffle: Bool
    static let originalPoems = Poem100.readPoemsFromJson()

    
    init(deck: [Poem] = originalPoems,
         shuffle mustShuffle: Bool = true) {
        self.deck = deck
        self.mustShuffle = mustShuffle
        if mustShuffle {
            self.deck.shuffle()
        }
    }
    
    var size: Int {
        deck.count
    }
 
    var currentIndex: Int {
        numberOfPoemsDrawn
    }
    
    var currentPoem: Poem? {
        guard currentIndex >= 1 else { return nil}
        return deck[currentIndex - 1]
    }
    
    var kamiNow: Bool {
        fuda_side == .kami
    }
    
    var side: Side? {
        fuda_side
    }
    
    var poemNumbers: [Int] {
        deck.map{ $0.number }
    }

    func shuffleDeck(with size: Int) {
        let shuffled = deck.shuffled()
        self.deck = shuffled.prefix(size).map{ $0 }
    }
    
    @discardableResult
    func drawNextPoem() -> Poem? {
        guard numberOfPoemsDrawn < deck.count else { return nil }
        let nextPoem = deck[numberOfPoemsDrawn]
        numberOfPoemsDrawn += 1
        setSideTo(.kami)
        return nextPoem
    }
    
    func rollBackPrevPoem() -> Poem? {
        switch numberOfPoemsDrawn {
        case 0:
            return nil
        case 1:
            numberOfPoemsDrawn = 0
            return nil
        default:
            numberOfPoemsDrawn -= 1
            return deck[numberOfPoemsDrawn - 1]
        }
    }
    
    func stepIntoShimo() {
        setSideTo(.shimo)
    }
    
    func backToKami() {
        setSideTo(.kami)
    }
    
    func addFakePoems() {
        guard size < 50 else {
            self.deck = Self.originalPoems.shuffled()
            return
        }
        let selectedPoemNumbers = deck.map{ $0.number }
        let int100 = Array(1...100)
        let restNumbers = int100.diff(selectedPoemNumbers.shuffled())
        for i in 0 ..< selectedPoemNumbers.count {
            let idx = restNumbers[i]
            self.deck.append(Self.originalPoems[idx - 1])
        }
        if mustShuffle {
            self.deck = deck.shuffled()
        }
    }
    
    func resetCurrentIndex() {
        self.numberOfPoemsDrawn = 0
    }
    
    private func setSideTo(_ side: Side) {
        self.fuda_side = side
    }
    
}
