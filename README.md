# Swift Cafe

An iOS SwiftUI App using MVVM & Combine 

## Features
- Authentication
- RESTful API Products Menu
- Core Data Shopping Cart

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
## Topics

This project is a starting point for an MVVM SwiftUI App.

- **iOS14** Min Deployment Target
- Use **MVVM** architecture
- Use **Async/Await** as it is beautiful
- Use **Combine** to make the ViewModels clean

## Architecture - MVVM Pattern

<img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/architecture.jpeg" width="720">

## Screenshot
|                                           Login Page                                           |                                           Menu Page                                           |                                           Cart Page                                           |
| :--------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------: |
| <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/login.jpeg" width="240"> | <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/menu.jpeg" width="240"> | <img src="https://github.com/jasontcs/SwiftCafe/blob/main/screenshots/cart.jpeg" width="240"> |
