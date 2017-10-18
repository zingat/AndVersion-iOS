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
#import "AndVersionConfiguration.h"

@interface AndVersion()

@property (nonatomic) NSString *previousAppVersion;

@property (nonatomic) AndVersionAlertView *alert;

@end


@implementation AndVersion

static NSString *previousVersionPreferenceKey = @"com.andversion.previousversion";

@synthesize previousAppVersion = _previousAppVersion;

+ (instancetype)sharedAndVersion
{
    static AndVersion *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[AndVersion alloc] init];
    });
    return shared;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _configuration = [AndVersionConfiguration new];
    }
    
    return self;
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


-(void) checkVersionWithUrl:(NSString *) urlString{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [weakSelf getJsonParameters: urlString];
    });
}

-(void) getJsonParameters:(NSString *) urlString{
    RemoteVersionInfo *remoteVersionInf = [[RemoteVersionInfo alloc] init];
    
    __weak typeof (self) weakSelf = self;
    [remoteVersionInf getDataWithUrl:urlString success:^{
        [weakSelf controlVersionJob: remoteVersionInf];
    }];
}

-(void) controlVersionJob:(RemoteVersionInfo *)remoteVersionInf{
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
