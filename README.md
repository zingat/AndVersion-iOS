# AndVersion

[![CI Status](http://img.shields.io/travis/kadirkemal/AndVersion.svg?style=flat)](https://travis-ci.org/kadirkemal/AndVersion)
[![Version](https://img.shields.io/cocoapods/v/AndVersion.svg?style=flat)](http://cocoapods.org/pods/AndVersion)
[![License](https://img.shields.io/cocoapods/l/AndVersion.svg?style=flat)](http://cocoapods.org/pods/AndVersion)
[![Platform](https://img.shields.io/cocoapods/p/AndVersion.svg?style=flat)](http://cocoapods.org/pods/AndVersion)

This is the library that checks updates on Apple Store according to json file from the given url address.



## SCREENSHOT

<img src="https://raw.githubusercontent.com/zingat/AndVersion-iOS/master/Example/images/andVersion-ios.png" width="100%">

### SAMPLE JSON FILE
```json
{
    "AndVersion": {
    "CurrentVersion": "1.8.3",
    "MinVersion": "1.2.5",
    "AppStoreId": "1088280260",
    "WhatsNew": {
        "en": [
            "3D home tours (where offered by rental listing).",
            "Minor enhancements to Schools information shown for a property",
            "Bug fixes and performance improvements"
        ],
        "tr": [
            "3D konut turu (danışman tarafından eklenmişse).",
            "Bir emlak etrafında gösterilen okul bilgileri için iyileştirmeler",
            "Hata düzeltmeleri ve performans iyileştirmeleri"
        ]
    }
    }
}

```
All fields are mandatory. If one of them is missing in the json file, AndVersion-iOS would not control the versions.

**CurrentVersion :** The version code on Apple Store.

**MinVersion :** The lowest version code that is wanted to be supported.

**AppStoreId :** Current apllication's store id.

**WhatsNew :** The list of new features that are added in the CurrentVersion.
The key of inner object should be **locale languge code** and the value of inner object shoul be **string array**.


## Installation

AndVersion is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'AndVersion'
```

## Usage

You can use AndVersion in three ways.

**With Delegate**

With this option, AndVersion notifies the current situation and this situation should be handled by the developer (if needed).
Add this code to didFinishLaunchingWithOptions in your AppDelagate.m

```objectivec
#import "AndVersion.h"

@interface zngAppDelegate() <AndVersionDelegate>
@end
```

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AndVersion sharedAndVersion].delegate = self;
    [[AndVersion sharedAndVersion] checkVersionWithUrl:@"https://andversion.com/sample/demoIOS.json"];
    
    // Override point for customization after application launch.
    return YES;
}
```

All methods in AndVersionDelegate are optional. You can implement only needed ones.
```objectivec
-(void) didAndVersionFindNoUpdate{
    NSLog(@"No New Version");
}

-(void) didAndVersionFindOptionalUpdate:(NSArray <NSString *> *) whatsNew{
    NSLog(@"Optional New Version");
    for(NSString *wNew in whatsNew){
        NSLog(@"%@", wNew);
    }
}

-(void) didAndVersionFindMandatoryUpdate:(NSArray <NSString *> *) whatsNew{
    NSLog(@"Mandatory New Version");
    for(NSString *wNew in whatsNew){
        NSLog(@"%@", wNew);
    }
}

-(void) didAndVersionMeetNewVersion:(NSArray <NSString *> *) whatsNew{
    NSLog(@"Meet New Version");
    for(NSString *wNew in whatsNew){
        NSLog(@"%@", wNew);
    }
}


```

**With Autopilot**

With this option, AndVersion controls the parameters in json file and handles the situations that are wanted.
Add this code to didFinishLaunchingWithOptions in your AppDelagate.m

```objectivec
#import "AndVersion.h"
```
#import "AndVersion.h"
```

```objective c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //if showAlertForNewVersion is set true, AndVersion shows whats new info view when the user must update his app.
    //The user can not use the app without updating
    [AndVersion sharedAndVersion].showAlertForMandatoryUpdate = YES;
    
    //if showAlertForOptionalUpdate is set true, AndVersion shows whats new info view when the app version is old but ok.
    //The user can use the app without updating
    [AndVersion sharedAndVersion].showAlertForOptionalUpdate = YES;
    
    //if showAlertForNewVersion is set true, AndVersion shows whats new info view when the user updates his app.
    [AndVersion sharedAndVersion].showAlertForNewVersion = YES;
    
    [[AndVersion sharedAndVersion] checkVersionWithUrl:@"https://andversion.com/sample/demoIOS.json"];
    
    // Override point for customization after application launch.
    return YES;
}

```

**With Callback and Autopilot**

You can use callback and autopilot features by implementing both of them.

## Parameters

These parameters is used only for autopilot mode. All there parameters have default value.


```objectivec
[AndVersion sharedAndVersion].configuration.infoViewBacgroundColor = [UIColor blueColor];
//Default value is [UIColor blackColor]

[AndVersion sharedAndVersion].configuration.infoViewBacgroundAlpha = 0.5;
//Default value is 0.85

[AndVersion sharedAndVersion].configuration.infoViewTableSeperatorColor = [UIColor greenColor];
//Default value is "89c400"
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewTitleColor = [UIColor redColor];
//Default value is [UIColor blackColor]

[AndVersion sharedAndVersion].configuration.infoinfoViewTitleFont = [UIFont fontWithName:@"FontName" size:16];
//Default value is [UIFont fontWithName:@"Verdana" size:14]

[AndVersion sharedAndVersion].configuration.infoViewTitleForNeedUpdate = @"Update your app for these awesome features";
//Default value is "It is recommended to update your applciation"

[AndVersion sharedAndVersion].configuration.infoViewTitleForNewVersion = @"Thanks for updating";
//Default value is "New features in this version"
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewButtonFont = [UIFont fontWithName:@"FontName" size:14];
//Default value is [UIFont fontWithName:@"Verdana" size:14]
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewOKButtonColor = [UIColor redColor];
//Default value is "89c400"

[AndVersion sharedAndVersion].configuration.infoViewOKButtonTextColor = [UIColor blackColor];
//Default value is [UIColor whiteColor]

[AndVersion sharedAndVersion].configuration.infoViewOKButtonTitle = @"OK";
//Default value is "Okay"
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewContinueButtonColor = [UIColor redColor];
//Default value is "d80e2b"

[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonTextColor = [UIColor blackColor];
//Default value is [UIColor whiteColor]

[AndVersion sharedAndVersion].configuration.infoViewContinueButtonTitle = @"GO";
//Default value is "Continue"
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonColor = [UIColor redColor];
//Default value is "89c400"

[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonTextColor = [UIColor blackColor];
//Default value is [UIColor whiteColor]

[AndVersion sharedAndVersion].configuration.infoViewUpdateButtonTitle = @"UPDATE";
//Default value is "Update"
```

```objectivec
[AndVersion sharedAndVersion].configuration.infoViewWhatsNewTextColor = [UIColor blackColor];
//Default value is [UIColor whiteColor]

[AndVersion sharedAndVersion].configuration.infoViewWhatsNewFont = [UIFont fontWithName:@"FontName" size:10];
//Default value is [UIFont fontWithName:@"Verdana" size:12]
```


## Author

Zingat Mobile Team
+ Kadir Kemal Dursun, https://github.com/KadirKemal
+ Muhammed Mortgy, https://github.com/Mortgy

## License

AndVersion is available under the MIT license. See the LICENSE file for more info.
