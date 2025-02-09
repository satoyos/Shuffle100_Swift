//
//  VolumeSettingViewModelTests.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/01/18.
//

@testable import Shuffle100
import XCTest
import Combine

final class VolumeSettingViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
  
    func testInitViewModel() {
        // given
      let viewModel = VolumeSettingViewModel.fixture(volume: 0.5)
        
        XCTAssertEqual(viewModel.binding.volume, 0.5)
        XCTAssertEqual(viewModel.output.ratioText, " 50")
    }
  
  func testWhenButtonTappedIsButtonDisabledTurnsToTrue() {
    // given
    let viewModel = VolumeSettingViewModel.fixture()
    // then
    XCTAssertFalse(viewModel.output.isButtonDisabled)
    // when
    viewModel.input.startTestRecitingRequest.send()
    // then
    let expectation = XCTestExpectation(description: "'isButtonDisabled' flag turns to true")
    viewModel.output.$isButtonDisabled
      .sink { bool in
        XCTAssertTrue(bool)
        expectation.fulfill()
      }
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 0.1)
  }
  
  func testWhenPlayerFinisedIsButtonDisabledTurnsToFalse() {
    // given
    let viewModel = VolumeSettingViewModel.fixture()
    // when
    viewModel.input.startTestRecitingRequest.send()
    // then
    
    // ToDo: Implement Production code to pass the test below.
    
    let expectation = XCTestExpectation(description: "'isButtonDisabled' flag turns back to false")
    viewModel.output.$isButtonDisabled
      .dropFirst()
      .sink { bool in
        XCTAssertFalse(bool)
        expectation.fulfill()
      }
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 12.0)
  }

}
