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

#### togg-appstore-carapp/app/src/main/AndroidManifest.xml


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

#### togg-appstore-carapp/app/src/main/java/tr/com/togg/appstore/MainActivity.kt

   ## Before 
        101    //toSecondScreen()

togg-appstore-carapp/app/src/main/java/tr/com/togg/appstore/MainActivity.kt, 
line 101. 
            
   ## After
        101    toSecondScreen()
          
       
         
   ## Create Simulator 
   
   ### Step 1 
   create simulator
   ![create_device](https://user-images.githubusercontent.com/68594765/205542642-7f7bb424-75d9-464e-9210-a59fa16d824c.png)

   ### Step 2    
   Select device definition
   ![clone_device](https://user-images.githubusercontent.com/68594765/205543656-844be32f-c824-49a5-90e3-823871e7e321.png)
   
   ### Step 3 
   Select system image
   ![Screenshot 2022-12-05 at 05 10 42](https://user-images.githubusercontent.com/68594765/205661882-75dbad43-5d89-4283-bfb6-00ce8da2eebb.png)

   
   ### Step 4
   #### set screen resolution and uncheck the portrait box
   ![Screenshot 2022-12-05 at 05 07 07](https://user-images.githubusercontent.com/68594765/205547591-7eb3b7b5-dbc3-440d-bd94-428c2bae9704.png)

  ![Screenshot 2022-12-05 at 05 12 07](https://user-images.githubusercontent.com/68594765/205663014-d631edc4-5e73-44cb-8d0a-da07f257e35c.png)

   ### Step 5
   #### Play the simultor
  ![Screenshot 2022-11-27 at 01 18 48](https://user-images.githubusercontent.com/68594765/205664280-ace69631-f0be-4cf9-9679-9ca5a91f13c7.png)
  
   ### Step 6
   #### set second screen resolution, and apply changes.
  ![Screenshot 2022-11-27 at 01 44 29](https://user-images.githubusercontent.com/68594765/205664273-61ff2857-fbb5-468e-9d04-bf7acadbb928.png)

  
