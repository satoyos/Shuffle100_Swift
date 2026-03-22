//
//  HomeView.swift
//  Shuffle100
//
//  HomeScreen.swift (UIKit) のSwiftUI版。
//  Phase 1で導入し、NavigationStackのルート画面として使用する。
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var router: AppRouter

  // Toggle用にローカルStateを持つ（Settings が objectWillChange を送出しないため）
  @State private var fakeMode: Bool = false
  @State private var showNoPoemAlert = false

  private var settings: Settings { router.settings }

  private var reciteModeName: String {
    switch settings.reciteMode {
    case .normal:   return "通常"
    case .beginner: return "初心者"
    case .nonstop:  return "ノンストップ"
    case .hokkaido: return "下の句かるた"
    }
  }

  private var singerName: String {
    Singers.getSingerOfID(settings.singerID)?.name ?? ""
  }

  var body: some View {
    List {
      // MARK: 設定セクション
      Section(header: Text("設定")) {

        // 取り札を用意する歌
        NavigationLink(value: AppRoute.poemPicker) {
          HStack {
            Text("取り札を用意する歌")
              .foregroundColor(.primary)
            Spacer()
            Text("\(settings.state100.selectedNum)首")
              .foregroundColor(.secondary)
          }
        }
        .accessibilityIdentifier("取り札を用意する歌")

        // 読み上げモード
        NavigationLink(value: AppRoute.selectMode) {
          HStack {
            Text("読み上げモード")
              .foregroundColor(.primary)
            Spacer()
            Text(reciteModeName)
              .foregroundColor(.secondary)
          }
        }
        .accessibilityIdentifier("読み上げモード")

        // 空札を加える（初心者モード以外）
        if settings.reciteMode != .beginner {
          Toggle("空札を加える", isOn: $fakeMode)
            .accessibilityIdentifier("空札を加える")
            .onChange(of: fakeMode) { _, newValue in
              settings.fakeMode = newValue
              router.saveSettings()
            }
        }

        // 読手
        NavigationLink(value: AppRoute.selectSinger) {
          HStack {
            Text("読手")
              .foregroundColor(.primary)
            Spacer()
            Text(singerName)
              .foregroundColor(.secondary)
          }
        }
        .accessibilityIdentifier("読手")
      }

      // MARK: 試合開始セクション
      Section(header: Text("試合開始")) {

        // 暗記時間タイマー（通常モードのみ）
        if settings.reciteMode == .normal {
          Button {
            guardPoems { router.push(.memorizeTimer) }
          } label: {
            HStack {
              Text("暗記時間タイマー")
                .foregroundColor(.primary)
              Spacer()
              Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption.weight(.semibold))
            }
          }
          .accessibilityIdentifier("暗記時間タイマー")
        }

        // 試合開始
        Button {
          guardPoems { startGame() }
        } label: {
          Text("試合開始")
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.red)
            .fontWeight(.bold)
        }
        .accessibilityIdentifier("試合開始")
      }
    }
    .listStyle(.grouped)
    .navigationTitle("トップ")           // UITestの app.navigationBars["トップ"] のために保持
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      // 「百首読み上げ」をプロンプト風にタイトル上部に表示
      ToolbarItem(placement: .principal) {
        VStack(spacing: 1) {
          Text("百首読み上げ")
            .font(.caption)
            .foregroundStyle(Color.primary)
          Text("トップ")
            .font(.headline.bold())
            .foregroundStyle(Color.primary)
        }
      }
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          router.presentSheet(.reciteSettings)
        } label: {
          Image("gear-520")
            .resizable()
            .renderingMode(.template)
            .frame(width: 32, height: 32)
        }
        .accessibilityLabel("GearButton")
        .accessibilityIdentifier("GearButton")
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          router.presentSheet(.help)
        } label: {
          Image("question_white")
            .resizable()
            .renderingMode(.template)
            .frame(width: 32, height: 32)
        }
        .accessibilityLabel("HelpButton")
        .accessibilityIdentifier("HelpButton")
      }
    }
    .toolbarBackground(Color(uiColor: StandardColor.barTintColor), for: .navigationBar)
    .toolbarBackground(.visible, for: .navigationBar)
    .onAppear {
      fakeMode = settings.fakeMode
    }
    .alert("歌を選びましょう", isPresented: $showNoPoemAlert) {
      Button("戻る", role: .cancel) {}
    } message: {
      Text("「取り札を用意する歌」で、試合に使う歌を選んでください")
    }
  }

  // MARK: - Private

  /// 歌が0首の場合はアラートを表示し、それ以外はアクションを実行する
  private func guardPoems(action: () -> Void) {
    if settings.state100.selectedNum == 0 {
      showNoPoemAlert = true
    } else {
      action()
    }
  }

  private func startGame() {
    AudioPlayerFactory.shared.setupAudioSession()
    let route: AppRoute
    switch settings.reciteMode {
    case .normal:   route = .normalMode
    case .beginner: route = .beginnerMode
    case .nonstop:  route = .nonstopMode
    case .hokkaido: route = .hokkaidoMode
    }
    router.push(route)
  }
}

#Preview {
  NavigationStack {
    HomeView()
      .environmentObject(AppRouter(settings: Settings(), store: StoreManager()))
  }
}
