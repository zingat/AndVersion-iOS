#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AndVersion.h"
#import "NSString+CheckVersion.h"
#import "RemoteVersionInfo.h"

FOUNDATION_EXPORT double AndVersionVersionNumber;
FOUNDATION_EXPORT const unsigned char AndVersionVersionString[];

