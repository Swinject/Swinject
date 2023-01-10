rm -r Swinject.xcframework

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-iOS \
-destination "generic/platform=iOS" \
-archivePath "$PWD/archives/Swinject-iOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-iOS \
-destination "generic/platform=iOS Simulator" \
-archivePath "$PWD/archives/Swinject-iOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-watchOS \
-destination "generic/platform=watchOS" \
-archivePath "$PWD/archives/Swinject-watchOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-watchOS \
-destination "generic/platform=watchOS Simulator" \
-archivePath "$PWD/archives/Swinject-watchOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-tvOS \
-destination "generic/platform=tvOS" \
-archivePath "$PWD/archives/Swinject-tvOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-tvOS \
-destination "generic/platform=tvOS Simulator" \
-archivePath "$PWD/archives/Swinject-tvOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-macOS \
-destination "generic/platform=macOS" \
-archivePath "$PWD/archives/Swinject-macOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-iOS \
-configuration Release \
-destination 'generic/platform=macOS,variant=Mac Catalyst' \
-archivePath "$PWD/archives/Swinject-macCatalyst" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
APPLICATION_EXTENSION_API_ONLY=YES \
SUPPORTS_MACCATALYST=YES

xcodebuild -create-xcframework \
-framework "Archives/Swinject-iOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-iOS.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-iOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-iOS-Simulator.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-watchOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-watchOS.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-watchOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-watchOS-Simulator.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-tvOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-tvOS.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-tvOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-tvOS-Simulator.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "Archives/Swinject-macOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-macOS.xcarchive/dSYMs/Swinject.framework.dSYM" \
-framework "$PWD/archives/Swinject-macCatalyst.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-debug-symbols "$PWD/archives/Swinject-macCatalyst.xcarchive/dSYMs/Swinject.framework.dSYM" \
-output Swinject.xcframework
