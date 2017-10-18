//
//  Configuration.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 18/10/2017.
//

#import <Foundation/Foundation.h>

@interface AndVersionConfiguration : NSObject

@property (nonatomic) NSString *titleForNeedUpdate;
@property (nonatomic) NSString *titleForNewVersion;
@property (nonatomic) NSString *okButtonTitle;
@property (nonatomic) NSString *continueButtonTitle;
@property (nonatomic) NSString *updateButtonTitle;

@property (nonatomic) UIColor *alertviewBacgroundColor;
@property (nonatomic) CGFloat alertviewBacgroundAlpha;

@end
