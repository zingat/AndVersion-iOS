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
#import "AndVersionAlertView.h"
#import "AndVersionConfiguration.h"
#import "NSString+CheckVersion.h"
#import "RemoteVersionInfo.h"
#import "UIColor+AndVersionColors.h"
#import "UILabel+Misc.h"

FOUNDATION_EXPORT double AndVersionVersionNumber;
FOUNDATION_EXPORT const unsigned char AndVersionVersionString[];

