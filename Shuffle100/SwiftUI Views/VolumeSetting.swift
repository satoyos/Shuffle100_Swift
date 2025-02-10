//
//  VolumeSetting.swift
//  Shuffle100
//
//  Created by Yoshifumi Sato on 2025/01/25.
//

import SwiftUI

struct VolumeSetting {
  let settings: Settings
  @ObservedObject private var viewModel: VolumeSettingViewModel
  @EnvironmentObject var screenSizeStore: ScreenSizeStore

  // To catch event: navigation back to Parent View of SwiftUI
  @Environment(\.isPresented) private var isPresented
  
  init(settings: Settings, volume givenVolume: Float? = nil) {
    let volume = givenVolume ?? settings.volume
    self.settings = settings
    self.viewModel = .init(
      volume: Double(volume),
      singer: Singers.fetchSingerFrom(settings))
  }
}

extension VolumeSetting: View {
  var body: some View {
    VStack {
      HStack(alignment: .bottom, spacing: 0) {
        ZStack(alignment: .trailing) {
          Text("100")
            .monospacedDigit()
            .font(.system(size: digitSize+8, weight: .medium))
            .opacity(0)
          Text(viewModel.output.ratioText)
            .monospacedDigit()
            .font(.system(size: digitSize, weight: .medium))
        }
        Text("%")
          .font(.system(size: digitSize / 4, weight: .medium))
          .padding(.trailing, digitSize / 2)
      }
      .padding()
      
      Slider(value: viewModel.$binding.volume, in: 0.0 ... 1.0, step: 0.01)
        .padding(.horizontal)
      
      Button("試しに聞いてみる") {
        viewModel.input.startTestRecitingRequest.send()
      }
      .buttonStyle(.borderedProminent)
      .foregroundStyle(Color.white)
      .padding(.top, digitSize * 0.5)
      .disabled(viewModel.output.isButtonDisabled)
    }
    .onChange(of: isPresented) {
      guard !isPresented else { return }
      tasksForLeavingThisView()
    }
    
  }
  
  func tasksForLeavingThisView() {
    reflectSliderValueToSettings()
    viewModel.stopReciting()
  }

  private func reflectSliderValueToSettings() {
    settings.volume = Float(viewModel.binding.volume)
  }

  private var digitSize: Double {
      screenSizeStore.screenWidth / 5.0
  }
}

#Preview {
  VolumeSetting(settings: Settings(), volume: 0.8)
    .environmentObject(ScreenSizeStore())
}
