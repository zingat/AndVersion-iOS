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

-(void) getDataWithUrl:(NSString *)urlString success:(void(^)(void))callback;
-(NSArray<NSString *>*) localWhatsNew;

@end
