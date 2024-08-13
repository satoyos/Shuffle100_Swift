//
//  RecitePlayButtonViewModelTests.swift
//  TrialButtonAnimationTests
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
        XCTAssertTrue(viewModel.isWaitingForPlay)
    }

    func testTappingButonChangesButtonType() {
        // given
        let viewModel = RecitePlayButton.ViewModel(type: .play)
        // when
        viewModel.playButtonTapped()
        // then
        XCTAssertEqual(viewModel.type, .pause)
        // when
        viewModel.playButtonTapped()
        // then
        XCTAssertEqual(viewModel.type, .play)
    }
}
