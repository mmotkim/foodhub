# foodhub

My demo flutter project using Firebase based from a Figma UI design FoodHub.
Created from VSCode's flutter new Application project template 

# Dev

You can contact me directly for help setting up development environment.

Steps:

Install Flutter SDK

Make sure you have installed Android Studio and an appropriate Android SDK version, Android SDK Command-line Tools, and Android SDK Build-Tools
(Required by Flutter)
Run ```flutter doctor``` to confirm above installations.

Launch Android Studio, click the Device Manager icon, and select Create Device under Virtual tab…
In older versions of Android Studio, you should instead launch Android Studio > Tools > Android > AVD Manager and select Create Virtual Device…. (The Android submenu is only present when inside an Android project.)
If you do not have a project open, you can choose 3-Dot Menu / More Actions > Virtual Device Manager and select Create Device…

Then
``` 
flutter doctor --android-licenses 
```

Finally, on your preferred IDE, run

```flutter pub get```
```flutter run```

# Generate Localization keys command

Everytime you add new localizable text keys while the project is built, run this command. This command also auto runs on build

```
dart run easy_localization:generate -S "assets/i18n/" -O "lib/gen" -o "locale_keys.g.dart" -f keys
```

