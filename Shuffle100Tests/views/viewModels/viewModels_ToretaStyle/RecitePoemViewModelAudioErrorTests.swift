//
//  RecitePoemViewModelAudioErrorTests.swift
//  Shuffle100Tests
//
//  Created by Claude on 2025/10/11.
//

import XCTest
import Combine
import AVFoundation
@testable import Shuffle100

final class RecitePoemViewModelAudioErrorTests: XCTestCase {

  var viewModel: RecitePoemViewModel!
  var testSettings: Settings!
  var mockFactory: MockAudioPlayerFactory!
  var cancellables: Set<AnyCancellable>!

  override func setUpWithError() throws {
    testSettings = Settings()
    testSettings.singerID = "ia"
    mockFactory = MockAudioPlayerFactory()
    viewModel = RecitePoemViewModel(settings: testSettings, audioPlayerFactory: mockFactory)
    viewModel.enableTestMode()
    cancellables = Set<AnyCancellable>()
  }

  override func tearDownWithError() throws {
    viewModel = nil
    testSettings = nil
    mockFactory = nil
    cancellables.removeAll()
    cancellables = nil
  }

  // MARK: - Factory Returns Nil Tests

  func test_playJoka_whenFactoryReturnsNil_handlesGracefully() throws {
    mockFactory.shouldReturnNil = true

    viewModel.playJoka(shorten: false)

    // Factory should be called
    XCTAssertTrue(mockFactory.prepareOpeningPlayerCalled)

    // Player should be nil
    XCTAssertNil(viewModel.currentPlayer)

    // Should not crash
    XCTAssertNotNil(viewModel)
  }

  func test_playNumberedPoem_whenFactoryReturnsNil_handlesGracefully() throws {
    mockFactory.shouldReturnNil = true

    viewModel.playNumberedPoem(number: 10, side: .shimo)

    // Factory should be called
    XCTAssertTrue(mockFactory.preparePlayerWithNumberCalled)

    // Player should be nil
    XCTAssertNil(viewModel.currentPlayer)

    // Should not crash
    XCTAssertNotNil(viewModel)
  }

  // MARK: - No Player Tests

  func test_pauseCurrentPlayer_whenNoPlayer_doesNotCrash() throws {
    // No player set
    XCTAssertNil(viewModel.currentPlayer)

    // Should not crash
    viewModel.pauseCurrentPlayer()

    XCTAssertNotNil(viewModel)
  }

  func test_playCurrentPlayer_whenNoPlayer_doesNotCrash() throws {
    // No player set
    XCTAssertNil(viewModel.currentPlayer)

    // Should not crash
    viewModel.playCurrentPlayer()

    XCTAssertNotNil(viewModel)
  }
}
