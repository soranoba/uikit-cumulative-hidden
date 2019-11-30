UIView.isHidden sometimes is not boolean
=====

This app will occur "impact feedback" when view have different value from set by isHidden.  
After rotating the device, please try to change the value of segmented control.  
It often occur "impact feedback".

Currently known conditions are that the view is in StackView and the state break when change value of "isHidden" during animation.  
(In the app, the state is broken by the rotate animation)


## Environments

- Xcode 11.2.1
- iOS 13.1

## References

- https://stackoverflow.com/questions/40001416/swift-disappearing-views-from-a-stackview
- https://stackoverflow.com/questions/56830523/cant-change-uiview-ishidden-property-after-action-is-called-by-uibarbutton
