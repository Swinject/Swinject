Pod::Spec.new do |s|
  s.name             = "Swinject"
  s.version          = "0.5"
  s.summary          = "Dependency injection framework for Swift"
  s.description      = <<-DESC
                       Swinject is a dependency injection framework for Swift, to manage the dependencies of types in your system.
                       DESC
  s.homepage         = "https://github.com/Swinject/Swinject"
  s.license          = 'MIT'
  s.author           = 'Swinject Contributors'
  s.source           = { :git => "https://github.com/Swinject/Swinject.git", :tag => s.version.to_s }

  shared_files = 'Swinject/*.swift'
  s.ios.source_files = shared_files, 'Swinject/iOS-tvOS/*.{swift,h,m}'
  s.osx.source_files = shared_files, 'Swinject/OSX/*.{swift,h,m}'
  s.watchos.source_files = shared_files, 'Swinject/watchOS/*.{swift,h,m}'
  s.tvos.source_files = shared_files, 'Swinject/iOS-tvOS/*.{swift,h,m}'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true
end
