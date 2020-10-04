Pod::Spec.new do |s|
  s.name             = "Swinject"
  s.version          = "2.7.1"
  s.summary          = "Dependency injection framework for Swift"
  s.description      = "Swinject is a dependency injection framework for Swift, to manage the dependencies of types in your system."

  s.homepage         = "https://github.com/Swinject/Swinject"
  s.license          = 'MIT'
  s.author           = 'Swinject Contributors'
  s.source           = { :git => "https://github.com/Swinject/Swinject.git", :tag => s.version.to_s }

  s.swift_version    = '5.0'
  s.source_files     = 'Sources/**/*.{swift,h}'

  s.ios.deployment_target     = '9.0'
  s.osx.deployment_target     = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target    = '9.0'
end
