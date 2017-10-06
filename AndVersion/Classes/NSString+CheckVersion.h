//
//  NSString+CheckVersion.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 04/10/2017.
//

#import <Foundation/Foundation.h>

@interface NSString (CheckVersion)

-(NSComparisonResult)compareToVersion:(NSString *)version;

@end
