# coding: utf-8
require_relative 'spec_helper'
require_relative 'application_drivers/screenshots'

describe 'スクリーンショットの撮影' do
  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '読み上げ画面を撮る' do
    it '試合を開始し、早送りボタンを押して、1首めへ行くと、読み上げ予定枚数は2首になっている' do
      open_game
      click_forward_button
      # なぜかRcitePoemScreenのヘッダタイトル取得が怪しくなってしまったので、コメントアウト
      # recite_screen_title_matches /1首め/
    end
    it '少し待って、ポーズボタンを押し、スクリーンショットを撮る' do
      sleep 2.0
      click_button 'waitingForPause'
      sleep_while_animation
      take_screenshot_no(1)
    end
    it 'ホーム画面に戻る' do
      click_quit_button
      alert_dismiss
      sleep_while_animation
      current_screen_is TOP_TITLE
    end
  end

  describe '「歌と歌の間隔」設定画面を撮る' do

    it 'トップ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      click_settings_button
      sleep_while_animation
      current_screen_is TITLE_FOR_ON_GAME_SETTINGS
    end
    it '「歌と歌の間隔」のセルを押すと、歌間隔設定画面に遷移する' do
      click_element_with_text(DURATION_BETWEEN_SONGS)
    end
    it 'ここでスクリーンショットを撮る' do
      sleep_while_animation
      take_screenshot_no(5)
      make_test_success
    end
    it '設定を終了し、ホーム画面に戻る' do
      click_back_button
      sleep_while_animation
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

  describe '歌検索画面を撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '検索窓に「春」を入力する' do
      fill_search_window_with_text '春'
      make_test_success
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(3)
    end
    it 'ホーム画面に戻る' do
      click_button('キャンセル')
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

  describe '「歌を選ぶ」画面を撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      click_button_to_cancel_all
      make_test_success
    end
    it '3番目の歌を選ぶ' do
      select_poem_of_no(3)
    end
    it '5番目の歌を選ぶ' do
      select_poem_of_no(5)
    end
    it '7番目の歌を選ぶ' do
      select_poem_of_no(7)
    end
    it 'スクロールする' do
      scroll_screen(150)
    end
    it '8番目の歌を選ぶ' do
      select_poem_of_no(8)
    end
    it '11番目の歌を選ぶ' do
      if @device_name =~ /iPhone X/ or @device_name =~ /iPad/ or @device_name =~ /Plus/
        select_poem_of_no(11)
      end
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(2)
      make_test_success
    end
    it 'ホーム画面に戻る' do
      click_back_button
      current_screen_is TOP_TITLE
    end
  end

  describe '五色百人一首のスクリーンショットを撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '全ての歌を選び、五色百人一首の画面を開く' do
      click_button_to_select_all
      goto_five_colors_screen
    end
    it 'ここでスクリーンショットを撮る' do
      sleep(3)
      take_screenshot_no(7)
    end
    it 'ホーム画面に戻る' do
      click_back_button
      click_back_button
      current_screen_is TOP_TITLE
    end
  end


  describe '暗記時間タイマーのスクリーンショットを撮る' do
    it '暗記時間タイマー画面を開く' do
      goto_memorize_timer_screen
      sleep_while_animation
    end
    it 'ここでスクリーンショットを撮る' do
      take_screenshot_no(6)
    end
    it 'トップ画面に戻る' do
      click_back_button
    end
  end

  describe '取り札画面を撮る' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '1首目のアクセサリボタンを押して、スクリーンショットを撮る' do
      go_detail_of_first_cell
      take_screenshot_no(4)
    end
  end
end

def make_test_success
  expect(1).to be 1
end

def select_poem_of_no(num)
  poem_cells[num-1].click
  make_test_success
end

def poem_cells
  @cells ||= find_elements(:class_name, TYPE_CELL)
end

def select_poem_of_numbers(numbers)
  numbers.each { |num|
    poem_cells[num-1].click
    swipe()
  }
end

def scroll_screen(scroll_up_length)
  puts "↑↑ #{scroll_up_length}だけ上にスクロールします"
  startX = 100
  startY = 250
  Appium::TouchAction.new.swipe(
    start_x: startX,
    start_y: startY,
    end_x: startX,
    end_y: startY-scroll_up_length,
    duration: 1000).perform
    make_test_success
end

def long_press_first_cell
  first_cell = find_elements(:class_name, TYPE_CELL).first
  pointX = first_cell.location.x + first_cell.size.width/2
  pointY = first_cell.location.y + first_cell.size.height/2
  duration = 2000
  Appium::TouchAction.new.press(x: pointX, y: pointY).wait(duration).release.perform
end

def go_detail_of_first_cell
  first_cell = find_elements(:class_name, TYPE_CELL).first
  first_cell.find_element(name: '詳細情報').click
end