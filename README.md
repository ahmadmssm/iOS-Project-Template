# ReadMe

## Intro:


## Project structure:
The project consists of multiple modules (Libraries), each module is responsible for something:

- **App module(Main module):**
   1. AppDelegate.
   2. App plist.
   3. DI Modules.
   4. Navigators.
   5. Splash screen.
   6. Features wiring.
   
- Features:
  1. AppCore features. 

- Frameworks:  

  - **Data module:**
       1. Rest client
	   2. Local caching using user defaults and core data inf needed.
	   3. Datasources.
	   4. Models.

  - **Core module:**
       1. Environment configurations.
       2. Localization.
       3. App utils.
       4. App delegate services.
       5. DI Framework.
       6. Firebase configs.
       7. Other configs.
       8. Extensions

   - **Servoces module:**
       1. RemoteLoggingService.
       2. AnalyticsService.
       3. JWTService.
       4. SerializationService.
       5. SimpleDataCachingService.
       6. LoggingService.
       7. InternetConnectivityService.
       8. SessionService.
    
    - **ResourcesModule:**
       1. Assets.
       2. Fonts.
       3. Strings.
       4. Colors.
    
    - **MVVM module:**
    
    - LookIn: debugging Framework.
    - WoodPecker: debugging Framework. 

## Workarounds:

## Problems and solutions:
   1. No such module ‘XYZ’ when archiving the App using my Swift package => [Check this](https://forums.swift.org/t/no-such-module-combine-when-archiving-app-using-my-swift-package/26372/2)

## Notes:
   1. There is a custom App main, It was created to allow having sparate DI containers for the App, and Unit testing and this was achieved by having two App delegates, one for the App and one for unit testing, and each DI container should belong to the corresponds App delegate.
   2. I used [Nuke](https://github.com/kean/Nuke) image loader instead of **KingFisher** because It is more efficient when it comes to memory management and has better performance plus almost all the features that we commonly use, check this [article](https://www.hackingwithswift.com/forums/ios/must-have-pods-libraries/21).
   3. [NetFox](https://github.com/kasketis/netfox) is used to log all the HTTP request in debug mode, just shake the device to see every incoming/outgoing HTTP request in the App.

## ToDos:
- []
- [] 
