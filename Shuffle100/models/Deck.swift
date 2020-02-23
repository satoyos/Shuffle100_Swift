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
    var poems: Array<Poem>
    private var count = 0
    
    init(poems: Array<Poem>) {
        self.poems = poems
    }
    
    convenience init() {
        self.init(poems: Deck.originalPoems)
    }
    
    static func create_from(state100: SelectedState100) -> Deck {
        var resultPoems: Array<Poem>
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
    
    func next_poem() -> Poem? {
        if count == poems.count {
            return nil
        } else {
            count+=1
            return poems[count-1]
        }
    }
    
    func rollback_poem() -> Poem? {
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
    
    func shuffle_with_size(size: Int) {
        let shuffled_poems = poems.shuffled()
        poems = []
        for i in 0..<size {
            poems.append(shuffled_poems[i])
        }
        
    }
    
    func shuffle() {
        shuffle_with_size(size: poems.count)
    }
    
    func add_fake_poems() {
        if self.size >= 50 {
            poems = Deck.originalPoems
            return
        }
        let selected_nums = poems.map{$0.number}
        let int100 = (Array<Int>)(1...100)
        let rest_nums = int100.diff(selected_nums).shuffled()
        for i in 0..<selected_nums.count {
            poems.append(Deck.originalPoems[rest_nums[i]-1])
        }
        poems.shuffle()
    }
}
