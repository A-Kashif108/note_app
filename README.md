# note_app

It is a demo app for flutter beginners.
It has a few features to get you started:
- basic CRUD operations
- auth from a third party
- local storage

## Getting Started

This project is for beginners to start learning Flutter by understandingj the code.

A few resources to get you started if this is your first Flutter project:
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Structure

```bash
note_app/lib/
├── core/                                   # for setting up router, locator
├── database/                               # for storing databases and db configurations
├── model/                                  # model classes: schemas for different objects
|   ├── user.dart                           # user model for auth
|   └── note.dart                           # note model
├── screens                                 # screens: views
|   ├── login_page.dart                     
|   ├── signup_page.dart                    
|   ├── home_page.dart                      
|   └── note_page.dart                      
├── services/                               # services
|   ├── auth_service.dart                   # AUTH implementations
|   ├── local_storage_service.dart          # service to store data locally
|   └── note_service.dart                   # API implementations for notes
├── utils/                                  # utilities such as color_combinations
└── main.dart                               # heart of the app
```

## Running

To build the app on your device you will need Flutter SDK, Android SDK, Android toolchain.
You will also need to plug your phone to PC through USB and make sure USB Debugging is enabled under Developer options

```
$ flutter clean
$ flutter pub get
$ flutter run
```
Note: if you are on VS Code or Android Studio you can choose option Run without Debugging which allows for hot reload and hot restart.

If you have any doubts feel free to chat with us [here](https://chat.mdgspace.org/)