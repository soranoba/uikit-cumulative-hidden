SwiftUI Preview sometimes outputs incorrect preview
=====

## Environments

- Xcode 15.2
- iOS 17.2

## References

- https://soranoba.net/programming/swiftui-outputs-incorrect-preview

## Overview

- Announce.swift
  - In the preview of Announce.swift, only the text is displayed. This means that SwiftUI.Group is used in Announce.body.
- Try Launch
  - It should be the same content, but this time a frame will be displayed. This means that Form.Group is used in Announce.body.

What is going on?
