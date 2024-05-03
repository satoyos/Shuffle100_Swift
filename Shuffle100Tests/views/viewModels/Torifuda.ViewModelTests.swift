//
//  Torifuda.ViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/05/03.
//  Copyright © 2024 里 佳史. All rights reserved.
//

@testable import Shuffle100
import XCTest

final class TorifudaViewModelTests: XCTestCase {

    func test_returns1CharStringForRowAndCol() {
        let shimo = "ひとをもみをもうらみさらまし"
        let viewModel = Torifuda.ViewModel(shimo: shimo)
        
        let str1 = viewModel.strForPosition(row: 2, col: 0)
        XCTAssertEqual(str1, "ま")
        
        let str2 = viewModel.strForPosition(row: 4, col: 2)
        XCTAssertEqual(str2, "み")
    }
    
    func test_whenShimoLengthShorterThan15ReturnsZenkakuSpaceForRow4Col0() {
        let shimo = "ひとをもみをもうらみさらまし"
        let viewModel = Torifuda.ViewModel(shimo: shimo)
        
        let str = viewModel.strForPosition(row: 4, col: 0)
        
        XCTAssertEqual(str, " ")
    }

}
