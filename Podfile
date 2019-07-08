# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'

use_frameworks!

install! 'cocoapods', :disable_input_output_paths => true

target 'Shuffle100' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    # Pods for Shuffle100
  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SnapKit', '~> 5.0.0', :inhibit_warnings => true
  pod 'BBBadgeBarButtonItem', git: 'https://github.com/TanguyAladenise/BBBadgeBarButtonItem.git'
  pod 'Then'
  pod 'DSFloatingButton'
  pod 'FontAwesome.swift'

  target 'Shuffle100Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Shuffle100UITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
