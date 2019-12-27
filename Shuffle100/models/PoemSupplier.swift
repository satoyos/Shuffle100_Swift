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
    
    init(deck: Deck, shuffle: Bool) {
        self.deck = deck
        if shuffle {
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
    
    var current_index: Int {
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
    
    var kami_now: Bool {
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
        current_poem = deck.next_poem()
        switch current_poem {
        case nil:
            return nil
        default:
            self.fuda_side = .kami
            return current_poem
        }
    }
    
    func rollback_prev_poem() -> Bool {
        current_poem = deck.rollback_poem()
        switch current_poem {
        case nil:
            return false
        default:
            return true
        }
    }
    
    func step_into_shimo() {
        self.fuda_side = .shimo
    }
    
}
