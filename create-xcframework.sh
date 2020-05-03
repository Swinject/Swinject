rm -r Swinject.xcframework

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-iOS \
-destination "generic/platform=iOS" \
-archivePath "archives/Swinject-iOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-iOS \
-destination "generic/platform=iOS Simulator" \
-archivePath "archives/Swinject-iOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-watchOS \
-destination "generic/platform=watchOS" \
-archivePath "archives/Swinject-watchOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-watchOS \
-destination "generic/platform=watchOS Simulator" \
-archivePath "archives/Swinject-watchOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-tvOS \
-destination "generic/platform=tvOS" \
-archivePath "archives/Swinject-tvOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-tvOS \
-destination "generic/platform=tvOS Simulator" \
-archivePath "archives/Swinject-tvOS-Simulator" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
-project Swinject.xcodeproj \
-scheme Swinject-macOS \
-destination "generic/platform=macOS" \
-archivePath "archives/Swinject-macOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
-framework "Archives/Swinject-iOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-iOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-watchOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-watchOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-tvOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-tvOS-Simulator.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-framework "Archives/Swinject-macOS.xcarchive/Products/Library/Frameworks/Swinject.framework" \
-output Swinject.xcframework
