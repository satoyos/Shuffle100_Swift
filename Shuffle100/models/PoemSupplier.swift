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


class PoemSupplier {
    var deck: Deck
    private var current_poem: Poem?
    private var fuda_side: Side?
    private var mustShuffle: Bool
    
    init(deck: Deck, shuffle mustShuffle: Bool = true) {
        self.deck = deck
        self.mustShuffle = mustShuffle
        if mustShuffle {
            deck.shuffle()
        }
    }
    
    convenience init() {
        self.init(deck: Deck(), shuffle: true)
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
        
    func drawNextPoem() -> Poem? {
        current_poem = deck.nextPoem()
        switch current_poem {
        case nil:
            return nil
        default:
            self.fuda_side = .kami
            return current_poem
        }
    }
    
    func rollBackPrevPoem() -> Poem? {
        current_poem = deck.rollBackPoem()
        switch current_poem {
        case nil:
            return nil
        default:
            self.fuda_side = .shimo
            return current_poem
        }
    }
    
    func stepIntoShimo() {
        self.setSideTo(.shimo)
    }
    
    func backToKami() {
        self.setSideTo(.kami)
    }
    
    func addFakePoems() {
        deck.addFakePoems()
        if mustShuffle {
            deck.shuffle()
        }
    }
    
    private func setSideTo(_ side: Side) {
        self.fuda_side = side
    }
    
    
}
