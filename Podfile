project 'Sample.xcodeproj'

platform :ios, '13.0'

target :Sample do
  inherit! :search_paths
  use_frameworks!

  pod 'Package1', path: './'
  pod 'Package2', path: './'

  target :SampleTests do
    pod 'Quick'
    pod 'Nimble'
  end
end
