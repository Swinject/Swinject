Pod::Spec.new do |s|
  s.name             = "Swinject"
  s.version          = "0.2.2"
  s.summary          = "Dependency injection framework for Swift"
  s.description      = <<-DESC
                       Swinject is a dependency injection framework for Swift, to manage the dependencies of types in your system.
                       DESC
  s.homepage         = "https://github.com/Swinject/Swinject"
  s.license          = 'MIT'
  s.author           = 'Swinject Contributors'
  s.source           = { :git => "https://github.com/Swinject/Swinject.git", :tag => s.version.to_s }

  s.source_files = 'Swinject/**/*.{swift,h,m}'
  s.ios.exclude_files = 'Swinject/OSX'
  s.osx.exclude_files = 'Swinject/iOS'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true
end
