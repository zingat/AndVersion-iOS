//
//  Configuration.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 18/10/2017.
//

#import <Foundation/Foundation.h>

@interface AndVersionConfiguration : NSObject

@property (nonatomic) NSString *infoViewTitleForNeedUpdate;
@property (nonatomic) NSString *infoViewTitleForNewVersion;

@property (nonatomic) NSString *infoViewOKButtonTitle;
@property (nonatomic) NSString *infoViewContinueButtonTitle;
@property (nonatomic) NSString *infoViewUpdateButtonTitle;

@property (nonatomic) UIColor *infoViewBacgroundColor;
@property (nonatomic) CGFloat infoViewBacgroundAlpha;

@property (nonatomic) UIColor *infoViewTitleColor;
@property (nonatomic) UIFont *infoViewTitleFont;

@property (nonatomic) UIColor *infoViewTableSeperatorColor;

@property (nonatomic) UIColor *infoViewOKButtonColor;
@property (nonatomic) UIColor *infoViewOKButtonTextColor;

@property (nonatomic) UIColor *infoViewUpdateButtonColor;
@property (nonatomic) UIColor *infoViewUpdateButtonTextColor;

@property (nonatomic) UIColor *infoViewContinueButtonColor;
@property (nonatomic) UIColor *infoViewContinueButtonTextColor;

@property (nonatomic) UIFont *infoViewButtonFont;

@property (nonatomic) UIColor *infoViewWhatsNewTextColor;
@property (nonatomic) UIFont *infoViewWhatsNewFont;

@end
