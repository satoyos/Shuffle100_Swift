require_relative 'string_with_utf8_mac'

# SCREEN SHOTS
SCREEN_SHOTS_FOLDER = './screenshots'

def take_screenshot_no(num)
  sleep_while_animation
  @driver.save_screenshot("#{SCREEN_SHOTS_FOLDER}/#{@device_name.gsub(/ /, '_')}_#{num}.png")
end

