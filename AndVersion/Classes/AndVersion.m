//
//  AndVersion.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import "AndVersion.h"
#import "RemoteVersionInfo.h"
#import "NSString+CheckVersion.h"

#import "AndVersionAlertView.h"

@interface AndVersion()

@property (nonatomic) NSString *previousAppVersion;

@property (nonatomic) AndVersionAlertView *alert;

@end


@implementation AndVersion

static NSString *previousVersionPreferenceKey = @"com.andversion.previousversion";

@synthesize previousAppVersion = _previousAppVersion;
@synthesize titleForNeedUpdate = _titleForNeedUpdate;
@synthesize titleForNewVersion = _titleForNewVersion;
@synthesize okButtonTitle = _okButtonTitle;
@synthesize continueButtonTitle = _continueButtonTitle;
@synthesize updateButtonTitle = _updateButtonTitle;

+ (instancetype)sharedAndVersion
{
    static AndVersion *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[AndVersion alloc] init];
    });
    return shared;
}

-(NSString *)previousAppVersion{
    if(_previousAppVersion == nil){
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        _previousAppVersion = [preferences objectForKey:previousVersionPreferenceKey];
    }
    return _previousAppVersion;
}

-(void)setPreviousAppVersion:(NSString *)previousVersion{
    _previousAppVersion = previousVersion;
 
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:_previousAppVersion forKey:previousVersionPreferenceKey];
    [preferences synchronize];
}

-(NSString *)titleForNeedUpdate{
    if(_titleForNeedUpdate){
        return _titleForNeedUpdate;
    }
    return @"It is recommended to update your applciation";
}
-(void)setTitleForNeedUpdate:(NSString *)titleForNeedUpdate{
    _titleForNeedUpdate = titleForNeedUpdate;
}

-(NSString *)titleForNewVersion{
    if(_titleForNewVersion){
        return _titleForNewVersion;
    }
    return @"New features in this version";
}
-(void)setTitleForNewVersion:(NSString *)titleForNewVersion{
    _titleForNewVersion = titleForNewVersion;
}

-(NSString *)okButtonTitle{
    if(_okButtonTitle){
        return _okButtonTitle;
    }
    return @"Okay";
}
-(void)setOkButtonTitle:(NSString *)okButtonTitle{
    _okButtonTitle = okButtonTitle;
}

-(NSString *)continueButtonTitle{
    if(_continueButtonTitle){
        return _continueButtonTitle;
    }
    return @"Continue";
}
-(void)setContinueButtonTitle:(NSString *)continueButtonTitle{
    _continueButtonTitle = continueButtonTitle;
}

-(NSString *)updateButtonTitle{
    if(_updateButtonTitle){
        return _updateButtonTitle;
    }
    return @"Update";
}
-(void)setUpdateButtonTitle:(NSString *)updateButtonTitle{
    _updateButtonTitle = updateButtonTitle;
}


-(void) checkVersionWithUrl:(NSString *) urlString{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [weakSelf controlVersionJob: urlString];
    });
}

-(void) controlVersionJob:(NSString *) urlString{
    RemoteVersionInfo *remoteVersionInf = [[RemoteVersionInfo alloc] initWithUrl:urlString];
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = [info objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"Current App Version : %@ - Previous App Version : %@", currentAppVersion, self.previousAppVersion);
    NSLog(@"Json File Min App Version : %@ - Json File Current App Version : %@", remoteVersionInf.minVersion, remoteVersionInf.currentVersion);
    
    _appStoreId = remoteVersionInf.appStoreId;
    
    //mandatory update
    if([currentAppVersion compareToVersion:remoteVersionInf.minVersion] == NSOrderedDescending){
        [self notifyDelegate:@selector(didAndVersionFindMandatoryUpdate:) withObject:remoteVersionInf.localWhatsNew];
        if(_showAlertForMandatoryUpdate){
            [self showAlert:AndVersionAlertViewTypeMandatoryUpdate whatsNew:remoteVersionInf.localWhatsNew];
        }
        return;
    }
    
    //optional update
    if([currentAppVersion compareToVersion:remoteVersionInf.currentVersion] == NSOrderedDescending){
        self.previousAppVersion = currentAppVersion;
        [self notifyDelegate:@selector(didAndVersionFindOptionalUpdate:) withObject:remoteVersionInf.localWhatsNew];
        if(_showAlertForOptionalUpdate){
            [self showAlert:AndVersionAlertViewTypeOptionalUpdate whatsNew:remoteVersionInf.localWhatsNew];
        }
        
        return;
    }
    
    
    if(self.previousAppVersion == nil //the app is running first time, no need to show whats new
       || [currentAppVersion compareToVersion:remoteVersionInf.currentVersion] == NSOrderedAscending //device version is newer then json version
       || [currentAppVersion compareToVersion:self.previousAppVersion] == NSOrderedSame //no update 
       ){
        self.previousAppVersion = currentAppVersion;
        [self notifyDelegate:@selector(didAndVersionFindNoUpdate) withObject:nil];
        return;
    }
    
    //meet new local version
    self.previousAppVersion = currentAppVersion;
    [self notifyDelegate:@selector(didAndVersionMeetNewVersion:) withObject:remoteVersionInf.localWhatsNew];
    if(_showAlertForNewVersion){
        [self showAlert:AndVersionAlertViewTypeNewVersion whatsNew:remoteVersionInf.localWhatsNew];
    }
}

-(void) notifyDelegate:(SEL)selector withObject:(nullable id)arg{
    if(_delegate == nil || [_delegate respondsToSelector:selector] == NO){
        return;
    }
    
    [_delegate performSelectorOnMainThread:selector withObject:arg waitUntilDone:YES];
}

-(void) showAlert:(AndVersionAlertViewType)andVersionAlertViewType whatsNew:(NSArray <NSString *> *) whatsNew{
    dispatch_async(dispatch_get_main_queue(), ^{
        _alert = [AndVersionAlertView new];
        [_alert show:andVersionAlertViewType whatsNew:whatsNew];
    });
}

@end
