//
//  AndVersion.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import <Foundation/Foundation.h>
#import "AndVersionConfiguration.h"

@protocol AndVersionDelegate <NSObject>

@optional

-(void) didAndVersionFindNoUpdate;
-(void) didAndVersionFindOptionalUpdate:(NSArray <NSString *> *) whatsNew;
-(void) didAndVersionFindMandatoryUpdate:(NSArray <NSString *> *) whatsNew;

-(void) didAndVersionMeetNewVersion:(NSArray <NSString *> *) whatsNew;

@end

@interface AndVersion : NSObject

@property (weak) NSObject<AndVersionDelegate>* delegate;
@property (nonatomic) bool showAlertForMandatoryUpdate;
@property (nonatomic) bool showAlertForOptionalUpdate;
@property (nonatomic) bool showAlertForNewVersion;

@property (nonatomic) NSString *appStoreId;
@property (nonatomic) AndVersionConfiguration *configuration;

+ (instancetype)sharedAndVersion;
- (void) checkVersionWithUrl:(NSString *) urlString;

@end
