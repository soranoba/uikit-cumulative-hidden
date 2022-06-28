Pod::Spec.new do |s|
  s.name             = 'Package2'
  s.version          = '0.1.0'
  s.summary          = 'No description'
  s.homepage         = 'https://soranoba.net'
  s.license          = { :type => 'NONE', :text => '' }
  s.author           = { 'soranoba' => 'contact@soranoba.net' }
  s.source           = { :git => 'https://github.com/soranoba/iOS-Sandbox', :branch => 'master' }

  s.ios.deployment_target = '13.0'
  s.swift_version         = '5'

  s.source_files        = "package2/*.swift"
  s.resource_bundles    = { 'Resources2' => ["package2/*.xcassets"] }
end
