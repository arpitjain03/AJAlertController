# AJAlertController
AJAlertController is a simple, customizable alert view written in Swift.
It is well managed for working on all screens and devices supporting iOS 9.0 and later.


[![Simulator_Screen_Shot_1.png](https://s7.postimg.org/689x7jarv/Simulator_Screen_Shot_1.png)](https://postimg.org/image/g5ky0lidj/)
&nbsp; &nbsp; &nbsp; &nbsp;
[![Simulator_Screen_Shot_2.png](https://s7.postimg.org/n8stg7viz/Simulator_Screen_Shot_2.png)](https://postimg.org/image/v1jh871hz/)

## Requirements
iOS 9.0+ and Swift 4 are required. 

## Installation
Just Drag and Drop `AJAlertController` folder in your project. 

## Features

- [x] Easy to use anywhere, as it is added on topmost view controller.
- [x] Convenient alert view with title, message and buttons
- [x] Appears with transition animations
- [x] Easily customizable appearance, including fonts, colours, corner radius, shadow, overlay colour and blur, etc.
- [x] Can be dismissed on background tap.
- [x] Works on all screens and devices supporting iOS 9.0 and later.


## Example

You can find this example in the project repo. To see it in action clone the repo and run the sample project.
 
```swift
/// Pass alert message, cancel button title, other button title
AJAlertController.initialization().showAlert(aStrMessage: "This is Alert message with two buttons", 
                                             aCancelBtnTitle: "NO", 
                                             aOtherBtnTitle: "YES") 
{ (index, title) in
    print(index,title)
}
```

```swift
/// Pass alert message
AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "This is normal alert message") 
{ (index, title) in
    print(index,title)
}
```

## Usage

### Initialization

```swift
AJAlertController.initialization()
```

### Display an Alert

```swift
public func showAlert( aStrMessage: String,
                       aCancelBtnTitle: String?,
                       aOtherBtnTitle: String? ,
                       completion : alertCompletionBlock) 
```

### Display an Alert with OK Button

```swift
public func showAlertWithOkButton( aStrMessage:String,
                                   completion : alertCompletionBlock)
```

## License

`AJAlertController` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Author
For any queries and suggestions reach out at arpit.cor@gmail.com
