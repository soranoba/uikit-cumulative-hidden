Don't use UITableViewCell.isHidden
=====

We should not be used UITableViewCell.isHidden in Applications running on iOS15 and built on Xcode13.<br>
Because, we can hide the UITableViewCell once it was displayed by UITableView, but we cannot show it again.<br>
<br>
This program is to reproduce the situation. You can show or hide the Cell from the edit button on the navigation.

## Environments

- Xcode 13.0
- iOS 15.0
