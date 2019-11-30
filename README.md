UITableViewCell.accessoryView.tintColor automatically set nil when the device rotated.
=====

When a button is set in UITableViewCell.accessoryView, tintColor is set to nil when the device is rotated. ~
To avoid this, you need to change UITableViewCell.tintColor instead of setting accessoryView.tintColor.

## Environments

- Xcode 13.3.1
- iOS 15.4
- Swift 5.6

## Blog post

- [Japanese](https://soranoba.net/programming/uitableviewcell-accessoryview-tintcolor)
