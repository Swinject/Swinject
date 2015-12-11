# Welcome to Swinject

Thank you for your interest to Swinject!

## Reporting Issues

Nothing is off-limits to submit as an issue. Feel free to submit an issue for a bug, strange behavior, build failure, new feature request or anything you would like to report.

It is helpful if you include the followings when you submit an issue for a bug:

- Your Xcode version
- Your Swinject version (or git SHA)
- The steps to reproduce the issue

If you would like to ask general questions about Swinject, it is preferable to ask at [Stack Overflow](http://stackoverflow.com) because questions there are more discoverable with Google by other people who have the same questions. The author of Swinject monitors `swinject` tag to answer as quickly as possible.

## Pull Requests

Pull requests are more appreciated to improve Swinject or to fix problems. Any kind of pull requests are welcome.

### Getting Started

Framework dependencies of Swinject are managed with [Carthage](https://github.com/Carthage/Carthage/releases). Make sure you have its latest version installed. The latest installer is available at [the Carthage release page](https://github.com/Carthage/Carthage/releases).

To setup a Swinject repository in your local Mac, run `git clone` command in Terminal.

`git clone --recursive git@github.com:Swinject/Swinject.git`

Move to the Swinject directory.

`cd Swinject`

Then run `carthage` command to download the frameworks that Swinject uses.

`carthage bootstrap --use-submodules --no-build`

Now it is ready to open `Swinject.xcodeproj`. Modify the code, run unit tests, and submit your pull request.

### Code Style

Please have a look at [GitHub Swift Style Guide](https://github.com/github/swift-style-guide), which the existing Swinject code tries to follow. If you have a case that is out of scope of the style guide, please try to match the style of the surrounding code.

If you have [SwiftLint](https://github.com/realm/SwiftLint) installed, some parts of coding style are automatically checked when you build the Swinject project.
The installation of SwiftLint to your environment is optional. [Hound CI](https://houndci.com) triggers SwiftLint to check your pull request.

### ERB Files

Some Swift source files are generated from ERB files, e.g. `Resolvable.swift` is generated from `Resolvable.erb`, to easily maintain a set of functions that only differ the number of arguments. The generated source files are located under `GeneratedCode` group in the Xcode project. Do not modify the generated code directly, but instead modify the source ERB code. After modifying the ERB code, run `script/gencode` script to generate the Swift code.

**Thank you for contributing!**
