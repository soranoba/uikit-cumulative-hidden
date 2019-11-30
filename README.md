OperationQueue is no longer used in URLSession
=====

URLSession used OperationQueue when calling delegation methods or completion handler, but it is no longer used in iOS14.<br>
This will cause the completion handler to be called even if the OperationQueue is waiting.<br>
<br>
This project shows the difference in behavior between iOS 13 and iOS 14.<br>
After it launches, please click the button.<br>
The log is output on iOS14, but it is not output on iOS13.<br>
<br>

## Environments

- Xcode 12.3
- iOS 13.0 / 14.3
