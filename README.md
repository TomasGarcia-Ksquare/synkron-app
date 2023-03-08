# The Ksquare Group - Synkron Mobile App

A Flutter project for The Ksquare Group.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## Installation

- Download flutter from [flutter.dev](https://flutter.dev/docs/get-started/install) and set the environment variables with your SDK route. This project use Flutter 3.3.10 and • Dart 2.18.6 • DevTools 2.15.0

MAC:

```bash
sudo nano ~/.bash_profile
```

```bash
export FLUTTER_SDK=/Users/<YOUR-USER>/Development/flutter
export PATH=$PATH:$FLUTTER_SDK/bin:$PATH
```

check your current and pending installations with:

```bash
flutter doctor
```

Set the Flutter Path (Just for MAC)

```bash
sudo nano /etc/paths 
```

```bash
/Users/<YOUR-USER>/Development/flutter/bin
```

- Download [Android studio](https://developer.android.com/studio) and set the environment variables with your SDK route

```bash
sudo nano ~/.bash_profile
```

```bash
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

- Download [Xcode and Xcode tools](https://developer.apple.com/xcode/) if you are using MACOS System
- Download the last [GIT Version](https://git-scm.com/downloads)
- Setup the emulators using XCode or Android Studio

## Configure Environment

- Copy the file .env located in assets/env/ in the same folder and rename it .env_dev
- Fill in the necessary data like url's and tokens
- Copy the file .env located in assets/env/ in the same folder and rename it .env_prod
- This one can be left as is unless you are building and artifact for release

## Configure Git Hooks

We added git hooks to check that our code keeps its quality.

### On Mac/Linux

Go to your root folder inside the project, open a new terminal and run:

```bash
sh scripts/install-hooks.bash
```

### On Windows

Having GitBash with symbolic links enable might work with previous instructions. If not then:

- Copy scripts/pre-push.bash into .git/hooks folder
- Rename file to pre-push

## Usage

Go to your root folder inside the project and open a new terminal:

- Install dependencies

```bash
flutter pub get
```

- finally, on Mobile

```bash
flutter run


- select the target device from the prompt



## Additionally

You can get all available commands for Flutter on the [Flutter CLI page](https://flutter.dev/docs/reference/flutter-cli)


## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

