//
//  RemoteVersionInfo.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import "RemoteVersionInfo.h"

@implementation RemoteVersionInfo

-(instancetype) initWithUrl:(NSString *) urlString{
    self = [super init];
    if(self){
        [self readFromUrl:urlString];
    }
    return self;
}

-(void) readFromUrl:(NSString *) urlString{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

    NSDictionary *andVersion = [json objectForKey:@"AndVersion"];
    self.currentVersion = [andVersion objectForKey:@"CurrentVersion"];
    self.minVersion = [andVersion objectForKey:@"MinVersion"];
    self.whatsNew = [andVersion objectForKey:@"WhatsNew"];
    self.appStoreId = [andVersion objectForKey:@"AppStoreId"];
    
    NSLog(@"json: %@", json);
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
