# Swift Cafe
An iOS [SwiftUI](https://developer.apple.com/xcode/swiftui/) App using MVVM (Model-View-ViewModel) pattern & [Combine](https://developer.apple.com/documentation/combine) Framework, support iOS14+
## Features
1. Authentication
2. RESTful API Products Menu
3. Core Data Shopping Cart

## Screenshot
|                                           Login Page                                           |                                           Menu Page                                           |                                           Cart Page                                           |
| :--------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: |
| <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/login.jpeg" width="240"> | <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/menu.jpeg" width="240"> | <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/cart.jpeg" width="240"> |

## Tech Stacks
- UI: iOS [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Design Pattern: MVVM (Model-View-ViewModel)
- Async Operations: [Async / Await](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/) & [Combine](https://developer.apple.com/documentation/combine) , to prevent callback hell & make the code clean
## Project Structure
```
SwiftCafe
├─ Assets.xcassets
│  └─ CafeThemeColor.colorset   # App Colors
├─ Models                       # Data Models struct
│  ├─ AuthModel.swift
│  └─ ProductModel.swift
├─ Repositories                 # Business Logic Repositories
│  └─ CafeRepository.swift
├─ Services                     # Data API
│  ├─ CoreDataService.swift
│  └─ NetworkService.swift
├─ SwiftCafeApp.swift           # SwiftUI App Life Cycle
├─ ViewModels                   # ViewModel for each View
│  ├─ CartViewModel.swift
│  ├─ LoginViewModel.swift
│  ├─ MainViewModel.swift
│  └─ MenuViewModel.swift
└─ Views                        # Contains a ViewModel per View
   ├─ CartView.swift
   ├─ LoginView.swift
   ├─ MainView.swift
   └─ MenuView.swift
```

## Architecture - MVVM Pattern

<img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/architecture.png" width="720">
