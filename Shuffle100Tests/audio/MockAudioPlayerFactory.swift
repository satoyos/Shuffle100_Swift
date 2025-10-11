//
//  MockAudioPlayerFactory.swift
//  Shuffle100Tests
//
//  Created by Yoshifumi Sato on 2025/10/09.
//

import Foundation
import AVFoundation
@testable import Shuffle100

/// AudioPlayerFactoryのモック実装
/// テスト時に音声ファイルなしで動作を検証可能にする
class MockAudioPlayerFactory: AudioPlayerFactoryProtocol {

  // MARK: - Call Tracking

  var setupAudioSessionCalled = false
  var prepareOpeningPlayerCalled = false
  var preparePlayerWithFileCalled = false
  var preparePlayerWithNumberCalled = false

  var lastOpeningPlayerFolder: String?
  var lastPlayerFolder: String?
  var lastPlayerFile: String?
  var lastPlayerType: String?
  var lastPlayerTitle: String?
  var lastPreparedNumber: Int?
  var lastPreparedSide: Side?

  // MARK: - Return Value Configuration

  /// trueの場合、すべてのpreparePlayer系メソッドがnilを返す（音声ファイルが見つからない状況をシミュレート）
  var shouldReturnNil = false

  /// 返すプレイヤーをカスタマイズしたい場合に設定
  var playerToReturn: AVAudioPlayer?

  // MARK: - AudioPlayerFactoryProtocol Implementation

  func setupAudioSession() {
    setupAudioSessionCalled = true
  }

  func prepareOpeningPlayer(folder: String) -> AVAudioPlayer? {
    prepareOpeningPlayerCalled = true
    lastOpeningPlayerFolder = folder
    return shouldReturnNil ? nil : (playerToReturn ?? createMockPlayer())
  }

  func preparePlayer(folder: String, file: String, ofType ext: String, title: String?) -> AVAudioPlayer? {
    preparePlayerWithFileCalled = true
    lastPlayerFolder = folder
    lastPlayerFile = file
    lastPlayerType = ext
    lastPlayerTitle = title
    return shouldReturnNil ? nil : (playerToReturn ?? createMockPlayer())
  }

  func preparePlayer(number: Int, side: Side, folder: String) -> AVAudioPlayer? {
    preparePlayerWithNumberCalled = true
    lastPreparedNumber = number
    lastPreparedSide = side
    lastPlayerFolder = folder
    return shouldReturnNil ? nil : (playerToReturn ?? createMockPlayer())
  }

  // MARK: - Helper Methods

  /// モック用のAVAudioPlayerを生成
  /// - Returns: 短い無音データを使ったプレイヤー
  private func createMockPlayer() -> AVAudioPlayer? {
    // 44.1kHz, 16bit, モノラルの無音データを1秒分生成
    // AVAudioPlayerが最低限必要とするヘッダー付きWAVデータ
    let sampleRate: Double = 44100.0
    let duration: Double = 1.0
    let numSamples = Int(sampleRate * duration)
    let dataSize = numSamples * 2 // 16bit = 2 bytes per sample

    var wavData = Data()

    // RIFF header
    wavData.append(contentsOf: "RIFF".utf8)
    var chunkSize = UInt32(36 + dataSize).littleEndian
    wavData.append(Data(bytes: &chunkSize, count: 4))
    wavData.append(contentsOf: "WAVE".utf8)

    // fmt subchunk
    wavData.append(contentsOf: "fmt ".utf8)
    var subchunk1Size = UInt32(16).littleEndian
    wavData.append(Data(bytes: &subchunk1Size, count: 4))
    var audioFormat = UInt16(1).littleEndian // PCM
    wavData.append(Data(bytes: &audioFormat, count: 2))
    var numChannels = UInt16(1).littleEndian // Mono
    wavData.append(Data(bytes: &numChannels, count: 2))
    var sampleRateValue = UInt32(sampleRate).littleEndian
    wavData.append(Data(bytes: &sampleRateValue, count: 4))
    var byteRate = UInt32(sampleRate * 2).littleEndian // SampleRate * NumChannels * BitsPerSample/8
    wavData.append(Data(bytes: &byteRate, count: 4))
    var blockAlign = UInt16(2).littleEndian // NumChannels * BitsPerSample/8
    wavData.append(Data(bytes: &blockAlign, count: 2))
    var bitsPerSample = UInt16(16).littleEndian
    wavData.append(Data(bytes: &bitsPerSample, count: 2))

    // data subchunk
    wavData.append(contentsOf: "data".utf8)
    var subchunk2Size = UInt32(dataSize).littleEndian
    wavData.append(Data(bytes: &subchunk2Size, count: 4))

    // Silent audio data (all zeros)
    wavData.append(Data(count: dataSize))

    return try? AVAudioPlayer(data: wavData)
  }

  // MARK: - Test Helper Methods

  /// すべての呼び出し履歴をリセット
  func reset() {
    setupAudioSessionCalled = false
    prepareOpeningPlayerCalled = false
    preparePlayerWithFileCalled = false
    preparePlayerWithNumberCalled = false
    lastOpeningPlayerFolder = nil
    lastPlayerFolder = nil
    lastPlayerFile = nil
    lastPlayerType = nil
    lastPlayerTitle = nil
    lastPreparedNumber = nil
    lastPreparedSide = nil
    shouldReturnNil = false
    playerToReturn = nil
  }
}
