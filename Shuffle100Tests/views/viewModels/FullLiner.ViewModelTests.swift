//
//  FullLinerViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/05/03.
//  Copyright © 2024 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

final class FullLinerViewModelTests: XCTestCase {

    func test_textReturnsStringConcatinated_includingNewLineCode() {
        let testFullLiner = ["やすらはで", "ねなまし物を", "さよ更けて", "かたふくまでの", "月を見しかな"]
        let viewModel = FullLiner.ViewModel(fullLiner: testFullLiner)
        
        XCTAssertEqual(viewModel.text, "やすらはで ねなまし物を さよ更けて\nかたふくまでの 月を見しかな")
    }

}
