Pod::Spec.new do |s|
  s.name             = "Swinject"
  s.version          = "1.1.5"
  s.summary          = "Dependency injection framework for Swift"
  s.description      = <<-DESC
                       Swinject is a dependency injection framework for Swift, to manage the dependencies of types in your system.
                       DESC
  s.homepage         = "https://github.com/Swinject/Swinject"
  s.license          = 'MIT'
  s.author           = 'Swinject Contributors'
  s.source           = { :git => "https://github.com/Swinject/Swinject.git", :tag => s.version.to_s }

  core_files = 'Sources/*.swift'
  umbrella_header_file = 'Sources/Swinject.h' # Must be at the end of 'source_files' to workaround CococaPods issue.
  storyboard_files = 'Sources/SwinjectStoryboard/*.{swift,h}'
  s.ios.source_files = core_files, storyboard_files, 'Sources/SwinjectStoryboard/iOS-tvOS/*.{swift,h,m}', umbrella_header_file
  s.osx.source_files = core_files, storyboard_files, 'Sources/SwinjectStoryboard/OSX/*.{swift,h,m}', umbrella_header_file
  s.watchos.source_files = core_files, umbrella_header_file
  s.tvos.source_files = core_files, storyboard_files, 'Sources/SwinjectStoryboard/iOS-tvOS/*.{swift,h,m}', umbrella_header_file
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true
end
