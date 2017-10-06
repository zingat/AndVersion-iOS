//
//  NSString+CheckVersion.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import "NSString+CheckVersion.h"

static NSString *versionSeparator = @".";

@implementation NSString (CheckVersion)

-(NSComparisonResult)compareToVersion:(NSString *)version{
    if([self isEqualToString:version]){
        return NSOrderedSame;
    }
    
    NSArray *myVersions = [self componentsSeparatedByString:versionSeparator];
    NSArray *newVersions = [version componentsSeparatedByString:versionSeparator];
    
    unsigned long minLength = MIN(myVersions.count, newVersions.count);
    
    for(int i = 0; i<minLength; i++){
        int myV = [[myVersions objectAtIndex:i] intValue];
        int newV = [[newVersions objectAtIndex:i] intValue];
        
        if(myV > newV){
            return NSOrderedAscending;
        }else if(myV < newV){
            return NSOrderedDescending;
        }
    }
    
    if(myVersions.count > newVersions.count){
        return NSOrderedAscending;
    }else if(myVersions.count < newVersions.count){
        return NSOrderedDescending;
    }
    
    return NSOrderedSame;
}

@end
