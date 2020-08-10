# coding: utf-8
require "rubygems"
require "appium_lib"
require_relative 'application_drivers/application_drivers'

# Screen Titles
TITLE = '百首読み上げ'
JOKA  = '序歌'
WHATS_NEXT_STR = '次はどうする？'
TITLE_FOR_ON_GAME_SETTINGS = 'いろいろな設定'
POEM_SELECTION_TITLE = '歌を選ぶ'
DURATION_BETWEEN_SONGS = '歌と歌の間隔'
TITLE_FOR_DURATION_BETWEEN_SONGS = '歌の間隔の変更'

DIALOGUE_MESSAGE_FOR_QUIT = '試合を終了しますか？'
TOP_TITLE = 'トップ'
ROOT = "."

def desired_caps
  {
      caps: {
          platformName:  "iOS",
          # deviceName:    "iPhone 8",
          # deviceName:    "iPhone X",
          # deviceName:    "iPhone Xs Max",  # 6.5inch
          # deviceName:    "iPhone 8 Plus",  # 5.5inch
          # deviceName:    "iPad Pro (9.7-inch)",
          deviceName:    "iPad Pro (12.9-inch) (2nd generation)",
          # deviceName:    "iPad Pro (12.9-inch) (4th generation)",
          platformVersion: "13.5",
          app: '../DerivedData/Shuffle100/Build/Products/Debug-iphonesimulator/Shuffle100.app',
          automationName: 'XCUITest',
          simpleIsVisibleCheck: true,
          iosInstallPause: 10000
      },
      appium_lib: {
          wait: 10
      }
  }
end

RSpec.configure { |c|
  c.before(:all) {
    @driver = Appium::Driver.new(desired_caps, true).start_driver
    @driver.manage.timeouts.implicit_wait = 2
    Appium.promote_appium_methods Object
    @device_name = desired_caps[:caps][:deviceName]
    clean_screenshots_folder
  }

=begin
  c.before(:each) do |example|
    unless @device_name =~ /iPad/  # <= Initializing recorder causes Error, so stop recording on iPad
      @recorder = Recorder.new(@driver)
      @recorder.start("#{ROOT}/screenshots/#{example.description}.mov")
    end
  end

  c.after(:each) { |example|
    if @recorder
      @recorder.stop

      # テストが通った場合は録画を消す（=失敗したものは残る）
      @recorder.remove_video unless example.exception
    end
  }
=end

  c.after(:all) {
    @driver.quit if @driver
  }
}

def clean_screenshots_folder
  FileUtils.chdir("screenshots")
  FileUtils.rm Dir.glob("*.mov")
  FileUtils.rm Dir.glob("*.png")
  FileUtils.chdir("..")
end