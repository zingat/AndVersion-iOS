//
//  RemoteVersionInfo.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import <Foundation/Foundation.h>

@interface RemoteVersionInfo : NSObject

@property (nonatomic) NSString* currentVersion;
@property (nonatomic) NSString* minVersion;
@property (nonatomic) NSString* appStoreId;
@property (nonatomic) NSDictionary* whatsNew;

-(instancetype) initWithUrl:(NSString *) urlString;
-(NSArray<NSString *>*) localWhatsNew;

@end
