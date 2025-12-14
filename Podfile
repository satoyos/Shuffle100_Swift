source 'https://github.com/CocoaPods/Specs.git'

# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

use_frameworks!

install! 'cocoapods', :disable_input_output_paths => true

target 'Shuffle100' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    # Pods for Shuffle100
#  pod 'Reveal-SDK', :configurations => ['Debug']
  pod 'SnapKit', '~> 5.6.0', :inhibit_warnings => true
#  pod 'Then'
#  pod 'DSFloatingButton'
  # pod 'FontAwesome.swift', :inhibit_warnings => true

  target 'Shuffle100Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Shuffle100UITests' do
    inherit! :search_paths
    # belows are introduced to avoid bug of Cocoapods,
    # so that UItest can be executed on Real Device
#    pod 'Reveal-SDK', :configurations => ['Debug']
    pod 'SnapKit', '~> 5.6.0', :inhibit_warnings => true
#    pod 'Then'
#    pod 'DSFloatingButton'
#    pod 'FontAwesome.swift'
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'No'
    end
  end
end
