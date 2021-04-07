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


struct PoemSupplier {
    var deck: Deck
    private var current_poem: Poem?
    private var fuda_side: Side?
    private var mustShuffle: Bool
    
    init(deck: Deck = Deck(), shuffle mustShuffle: Bool = true) {
        self.deck = deck
        self.mustShuffle = mustShuffle
        if mustShuffle {
            self.deck.shuffle()
        }
    }
    
    var size: Int {
        get {
            return deck.size
        }
    }
    
    var currentIndex: Int {
        get {
            return deck.counter
        }
    }

    var poem: Poem! {
        if let p = self.current_poem {
            return p
        } else {
            return nil
        }
        
    }
    
    var kamiNow: Bool {
        if let _ = self.current_poem {
            return fuda_side! == .kami
        } else {
            return false
        }
    }
    
    var side: Side? {
        return fuda_side
    }
    
    @discardableResult
    mutating func drawNextPoem() -> Poem? {
        current_poem = deck.nextPoem()
        switch current_poem {
        case nil:
            return nil
        default:
            self.fuda_side = .kami
            return current_poem
        }
    }
    
    mutating func rollBackPrevPoem() -> Poem? {
        current_poem = deck.rollBackPoem()
        switch current_poem {
        case nil:
            return nil
        default:
            self.fuda_side = .shimo
            return current_poem
        }
    }
    
    mutating func stepIntoShimo() {
        self.setSideTo(.shimo)
    }
    
    mutating func backToKami() {
        self.setSideTo(.kami)
    }
    
    mutating func addFakePoems() {
        deck.addFakePoems()
        if mustShuffle {
            deck.shuffle()
        }
    }
    
    mutating func resetCurrentIndex() {
        deck.resetCounter()
    }
    
    private mutating func setSideTo(_ side: Side) {
        self.fuda_side = side
    }
    
}
