//
//  RecitePlayButtonViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2024/07/23.
//

@testable import Shuffle100
import XCTest

final class RecitePlayButtonViewModelTests: XCTestCase {
    
    func testPlayFigureMeansItIsWaitingForPlay() {
        // given
        let viewModel = RecitePlayButton.ViewModel(type: .play)
        // then
        XCTAssertTrue(viewModel.output.isWaitingForPlay)
    }

    func testTappingButonChangesButtonType() {
      // given
      let viewModel = RecitePlayButton.ViewModel(type: .play)
      // when
      viewModel.input.playButtonTapped.send()
      // then
      XCTAssertEqual(viewModel.output.type, .pause)
      // when
      viewModel.input.playButtonTapped.send()
      // then
      XCTAssertEqual(viewModel.output.type, .play)
    }
}
