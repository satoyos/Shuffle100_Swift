//
//  VolumeSettingViewModelFixture.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/29.
//

@testable import Shuffle100

extension VolumeSettingViewModel {
  static func fixture(
    volume: Double = 0.8,
    singer: Singer = Singers.defaultSinger
  ) -> VolumeSettingViewModel {
    .init(
      volume: volume,
      singer: singer
    )
  }
}
