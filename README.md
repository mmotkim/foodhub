# foodhub

My demo flutter project using Firebase based from a Figma UI design [FoodHub](https://www.figma.com/file/NueFWtgzXMvNDuUNStNHln/Untitled?type=design&node-id=0-1&t=hjis4Gk8cACMH5xI-0).

Created from VSCode's flutter new Application project template 

# Dev

You can contact me directly for help setting up development environment.

Steps:

Install Flutter SDK

Make sure you have installed Android Studio and an appropriate Android SDK version, Android SDK Command-line Tools, and Android SDK Build-Tools
(Required by Flutter)

Run ```flutter doctor``` to confirm above installations.

Launch Android Studio, click the Device Manager icon, and Create Device under Virtual tab…

Then
``` 
flutter doctor --android-licenses 
```

Finally, on your preferred IDE, run

```
flutter pub get
```
```
flutter run
```

# Generate Localization keys command

Everytime you add new localizable text keys while the project is built, run this command. This command also auto runs on build

```
dart run easy_localization:generate -S "assets/i18n/" -O "lib/gen" -o "locale_keys.g.dart" -f keys
```

