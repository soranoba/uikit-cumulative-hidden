On Swift 5.6, type inference is not working properly when creating an instance of the same class from the Generics class
=====

When you open Sample.xcworkspace and build it, it fails to compile.  
`ViewController.didTapButton(_:)` and `OtherViewController.didTapButton(_:)` have the same code, but only `ViewController.didTapButton(_:)` fails to compile.  
This is probably because the types are over-restricted when recreating an instance of the same class within a method of a generics class.  
  
The workaround is 

- Execute from another class (`makeViewControllerWithMovieLoader2()`)
- Inherit classes and delete generics (`InheritedViewController(loader: MovieLoader2())`)

## Environments

- Xcode 13.3.1
- iOS 15.4
- Swift 5.6

## Blog post

- [Japanese](https://soranoba.net/programming/swift5.6-generics-bug)
