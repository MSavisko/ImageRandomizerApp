# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def install_dependencies
  pod 'Kingfisher', '5.3.0'
  pod 'RxSwift', '4.4.2'
  pod 'RxCocoa', '4.4.2'
  pod "RxGesture", '2.1.0'
  pod 'RealmSwift', '3.13.1'
  pod 'RxRealm', '0.7.6'
  pod 'R.swift', '5.0.2'
end

target 'ImageRandomizerApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImageRandomizerApp
  install_dependencies

  target 'ImageRandomizerAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ImageRandomizerAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
