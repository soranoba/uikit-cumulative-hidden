Using CocoaPods, framework resource images may not be read properly.
=====

If the CocoaPods framework uses images, it may not be able to load images, even if resources other than images (e.g. xib) can be loaded.<br>
This happens when the bundle identifiers are in conflict.<br>
Also, this only happens when reading an image from code.

### Workaround 1

[ebf820](https://github.com/soranoba/iOS-SandBox/commit/ebf820af29b112acf4e56045ed5d91b188640773)

Avoid conflict resource_bundles name. This should be unique in all frameworks.

### Workaround 2

[270dfa](https://github.com/soranoba/iOS-SandBox/commit/270dfaa7840fcfc629b0e0d4142cb5d61cf400b1)

Explicitly specify the bundle identifier. The bundle identifier, of course, must be unique.

## Environments

- CocoaPods 1.10.1
- Xcode 13.3.1
- iOS 15.3
