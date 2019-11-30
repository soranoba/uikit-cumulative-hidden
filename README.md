Avoid KVO_IS_RETAINING_ALL_OBSERVERS_OF_THIS_OBJECT_IF_IT_CRASHES_AN_OBSERVER_WAS_OVERRELEASED_OR_SMASHED
=====

When using `observe(_:options:changeHandler:)`, it sometimes occur crash even if `NSKeyValueObservation.invalidate()` is executed. ~
I think that it is because `NSObject.removeObserver(_:forKeyPath:context:)` may not be executed depending on the reference release order. ~

In this app, there are two samples that can be released correctly and a sample that crashes.
You may try to tap the `Danger`,` Safe-1`, and `Safe-2` buttons multiple times. ~

## Environments

- Xcode 11.4
- iOS 13.4

## Blog post

- [Japanese](https://soranoba.net/programming/kvo-observed-or-smashed)
