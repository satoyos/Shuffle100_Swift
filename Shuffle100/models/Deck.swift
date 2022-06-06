//
//  Deck.swift
//  Poems
//
//  Created by 里 佳史 on 2017/04/22.
//  Copyright © 2017年 里 佳史. All rights reserved.
//

//import Foundation
//
//struct Deck {
//    static let originalPoems = Poem100.originalPoems
//    var poems: [Poem]
//    private var count = 0
//    
//    init(poems: [Poem] = originalPoems) {
//        self.poems = poems
//    }
//     
//    static func createFrom(state100: SelectedState100) -> Deck {
//        var resultPoems: [Poem]
//        resultPoems = []
//        for i in 0..<100 {
//            if state100.bools[i] {
//                resultPoems.append(originalPoems[i])
//            }
//        }
//        return Self(poems: resultPoems)
//    }
//    
//    var size: Int {
//        get {
//            return poems.count
//        }
//    }
//    
//    var counter: Int {
//        get {
//            return self.count
//        }
//    }
//    
//    mutating func nextPoem() -> Poem? {
//        if count == poems.count {
//            return nil
//        } else {
//            count+=1
//            return poems[count-1]
//        }
//    }
//    
//    mutating func rollBackPoem() -> Poem? {
//        switch count {
//        case 0:
//            return nil
//        case 1:
//            count = 0
//            return nil
//        default:
//            count -= 1
//            return poems[count-1]
//        }
//    }
//    
//    mutating func shuffleWithSize(size: Int) {
//        let shuffledPoems = poems.shuffled()
//        poems = []
//        for i in 0..<size {
//            poems.append(shuffledPoems[i])
//        }
//        
//    }
//    
//    mutating func shuffle() {
//        shuffleWithSize(size: poems.count)
//    }
//    
//    mutating func addFakePoems() {
//        if self.size >= 50 {
//            poems = Self.originalPoems
//            return
//        }
//        let selectedNums = poems.map{$0.number}
//        let int100 = (Array<Int>)(1...100)
//        let restNums = int100.diff(selectedNums).shuffled()
//        for i in 0..<selectedNums.count {
//            poems.append(Deck.originalPoems[restNums[i]-1])
//        }
//    }
//    
//    mutating func resetCounter() {
//        self.count = 0
//    }
//    
//    func poemNumbers() -> [Int] {
//        return poems.map{$0.number}
//    }
//}
