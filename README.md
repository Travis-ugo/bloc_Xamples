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

#### run pub get, to get all packages used in this project.
            pub get
#### use generated files to generate router and serialisable. Generate .gr files before running the app
            flutter packages pub run build_runner build


#### remove code android:sharedUserId="android.uid.system”, while using an emulator.

            togg-appstore-carapp/app/src/main/AndroidManifest.xml


   ## Before
        <?xml version="1.0" encoding="utf-8"?>
        <!-- TODO remove android:sharedUserId="android.uid.system" for running the app in emulator-->
        <manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="tr.com.togg.appstore"
          android:sharedUserId="android.uid.system" >
                                   
      
   ## After
        <?xml version="1.0" encoding="utf-8"?>
        <!-- TODO remove android:sharedUserId="android.uid.system" for running the app in emulator-->
        <manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="tr.com.togg.appstore">
          <!-- android:sharedUserId="android.uid.system" > -->
         
         
         
## Simulator Set-Up

The Simulator is used to imitate the Togg car control screen and main screen during production
note:  when running the application on a simulator, uncomment the code in the Manifest file:

   ## Before 
        101    //toSecondScreen()

togg-appstore-carapp/app/src/main/java/tr/com/togg/appstore/MainActivity.kt, 
line 101. 
            
   ## After
        101    toSecondScreen()
                    
                    
                    
                    
                 
### Application Dependecies
                    :
Go to project root and execute the following command in console to get the required dependencies:
flutter pub get        
                    
            name: app_store_module
            description: A new Flutter module.

            publish_to: none

            version: 0.0.1+1

            environment:
            sdk: ">=2.17.0 <3.0.0"

            dependencies:
            flutter:
            sdk: flutter
            flutter_localizations:
            sdk: flutter

            cupertino_icons: ^1.0.2

            # https://pub.dev/packages/flutter_secure_storage
            flutter_secure_storage: ^5.0.2
            # https://pub.dev/packages/shared_preferences
            shared_preferences: ^2.0.15
            # https://pub.dev/packages/flutter_screenutil
            flutter_screenutil: 5.2.0
            # https://pub.dev/packages/logger
            logger: ^1.1.0
            # https://pub.dev/packages/glassmorphism
            glassmorphism: ^3.0.0
            # https://pub.dev/packages/flip_card
            flip_card: ^0.6.0
            # https://pub.dev/packages/flutter_svg
            flutter_svg: ^1.0.3
            # https://pub.dev/packages/cupertino_tabbar
            cupertino_tabbar: ^2.0.0
            # https://pub.dev/packages/auto_size_text
            auto_size_text: ^3.0.0
            # https://pub.dev/packages/group_radio_button
            group_radio_button: ^1.2.0
            # https://pub.dev/packages/auto_route
            auto_route: ^4.0.1

            # State Management
            # https://pub.dev/packages/bloc
            bloc: ^8.0.3
            # https://pub.dev/packages/flutter_bloc
            flutter_bloc: ^8.0.1
            # https://pub.dev/packages/flutter_hooks
            flutter_hooks: ^0.18.4
            # https://pub.dev/packages/equatable
            equatable: ^2.0.3

            # Dependency Injection
            # https://pub.dev/packages/get_it
            get_it: ^7.2.0

            # https://pub.dev/packages/very_good_analysis
            very_good_analysis: ^2.4.0
            # https://pub.dev/packages/json_annotation
            json_annotation: ^4.5.0
            # https://pub.dev/packages/flutter_downloader
            flutter_downloader: ^1.8.2
            # https://pub.dev/packages/path_provider
            path_provider: ^2.0.10
            # https://pub.dev/packages/device_apps
            device_apps: ^2.2.0
            # https://pub.dev/packages/crypto
            crypto: ^3.0.1
            # https://pub.dev/packages/android_path_provider
            android_path_provider: ^0.3.0
            # https://pub.dev/packages/sqflite
            sqflite: ^2.0.2+1
            # https://pub.dev/packages/md5_file_checksum
            md5_file_checksum: ^1.0.3
            # https://pub.dev/packages/connectivity_plus
            connectivity_plus: ^2.3.0

            external_app_launcher: ^3.1.0 

            togg_carapp_sdk_flutter:
            # path: ../../../../Flutter/togg-carapp-sdk-flutter
            git: 
            url: https://gitlab.home-ix.com/cooperations/togg/togg-carapp-sdk/togg-carapp-sdk-flutter.git
            ref: main

            app_store_library:
            # path: ../../togg-appstore-library
            git: 
            url: https://gitlab.home-ix.com/cooperations/togg/togg-appstore/togg-appstore-library.git
            ref: main

            dev_dependencies:
            flutter_test:
            sdk: flutter
            build_runner:
            flutter_gen_runner: ^4.1.6
            # https://pub.dev/packages/auto_route_generator
            auto_route_generator: ^4.0.0
            # https://pub.dev/packages/bloc_test
            bloc_test: ^9.0.3
            # https://pub.dev/packages/json_serializable
            json_serializable: ^6.2.0
            flutter_driver:
            sdk: flutter
            integration_test:
            sdk: flutter


            flutter_gen:
            output: lib/core/constants/
            line_length: 80

            integrations:
            flutter_svg: true

            flutter:
            generate: true
            uses-material-design: true

            assets:
            - assets/images/pngs/
            - assets/images/svgs/

            fonts:
            - family: Fedra-Sans-Std
            fonts:
            - asset: assets/fonts/Fedra-Sans-Std-Book.ttf
            - asset: assets/fonts/Fedra-Sans-Std-Bold.ttf
            weight: 700
            - asset: assets/fonts/Fedra-Sans-Std-Medium.ttf
            weight: 500

            module:
            androidX: true
            androidPackage: com.togg.appstore
            iosBundleIdentifier: com.togg.appstore

