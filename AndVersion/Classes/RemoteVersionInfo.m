//
//  RemoteVersionInfo.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import "RemoteVersionInfo.h"

@implementation RemoteVersionInfo

-(void) getDataWithUrl:(NSString *)urlString success:(void(^)(void))callback{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    if(data != nil){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if(error){
            return;
        }
        
        NSDictionary *andVersion = [json objectForKey:@"AndVersion"];
        self.currentVersion = [andVersion objectForKey:@"CurrentVersion"];
        self.minVersion = [andVersion objectForKey:@"MinVersion"];
        self.whatsNew = [andVersion objectForKey:@"WhatsNew"];
        self.appStoreId = [andVersion objectForKey:@"AppStoreId"];
        
        if(callback && self.currentVersion.length > 0 && self.minVersion.length > 0 && self.whatsNew.count > 0 && self.appStoreId.length > 0){
            callback();
        }
    }
}

-(NSArray<NSString *>*) localWhatsNew{
    NSString *language = [[[NSLocale preferredLanguages] firstObject] substringToIndex:2];
    
    NSArray<NSString *> *returnArr = [self.whatsNew objectForKey:language];
    if(returnArr){
        return returnArr;
    }
    
    returnArr = [self.whatsNew objectForKey:@"en"];
    if(returnArr){
        return returnArr;
    }
    
    if(self.whatsNew.allKeys.count == 0){
        return [NSArray<NSString *> new];
    }
    
    return [self.whatsNew objectForKey:[self.whatsNew.allKeys objectAtIndex:0]];
}

@end
