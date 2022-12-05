# Togg app store.

## About Togg App Store.⚡️⚡️
the Togg car application store is an AppStore specifically for the Togg smart car, the applications are installed in the car’s operating system, and displayed on the control screen and the main screen(dashboard). However, for production purposes, we use an emulator to imitate the car’s os behavior. The car app store displays a list of apps, that are downloadable by the car Togg client into the car.
the Togg App Store applications are built native andiod, with flutter emebeded. 

## Getting Started the Development environment.

the Togg car App Store is built with flutter version 3.3.4 and depends on
togg-carapp-sdk-flutter and 
togg-appstore-library library which are added to the pub spec file, alongside many other flutter packages.

add to the pub spec file under the flutter_module directory
togg-appstore-carapp/flutter_module/pubspec.yaml

- [togg_carapp_sdk_flutter](https://gitlab.home-ix.com/cooperations/togg/togg-carapp-sdk/togg-carapp-sdk-flutter) 
should be added in the pubspec.yaml to use flutter dual screen sdk communication. It's already added in the pubspec but sometimes in development it's directed to local path to test local changes before upload it to the repository. Remember to be aware that some dependencies have local path inside the workspace and git path with the repository.

- [togg-appstore-library](https://gitlab.home-ix.com/cooperations/togg/togg-appstore/togg-appstore-library)

run pub get, to get all packages used in this project.
            pub get
use generated files to generate router and serialisable. Generate .gr files before running the app
            flutter packages pub run build_runner build


remove code android:sharedUserId="android.uid.system”, while using an emulator.

  togg-appstore-carapp/app/src/main/AndroidManifest.xml

        <?xml version="1.0" encoding="utf-8"?>
        <!-- TODO remove android:sharedUserId="android.uid.system" for running the app in emulator-->
        <manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="tr.com.togg.appstore"
          android:sharedUserId="android.uid.system" >
          
       
       
        <?xml version="1.0" encoding="utf-8"?>
        <!-- TODO remove android:sharedUserId="android.uid.system" for running the app in emulator-->
        <manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="tr.com.togg.appstore">
          <!-- android:sharedUserId="android.uid.system" > -->
         
         
         
## Simulator Set-Up

The Simulator is used to imitate the Togg car control screen and main screen during production
note:  when running the application on a simulator, uncomment the code in the Manifest file: 

        //toSecondScreen()

togg-appstore-carapp/app/src/main/java/tr/com/togg/appstore/MainActivity.kt, 
line 101. 

        toSecondScreen()
