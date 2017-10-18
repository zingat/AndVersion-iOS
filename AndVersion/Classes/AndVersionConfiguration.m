//
//  Configuration.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 18/10/2017.
//

#import "AndVersionConfiguration.h"
#import "UIColor+AndVersionColors.h"

#define AND_VERSION_FONT @"Verdana"

@implementation AndVersionConfiguration

-(instancetype)init{
    self = [super init];
    if(self){
        _infoViewTitleForNeedUpdate = @"It is recommended to update your applciation";
        _infoViewTitleForNewVersion = @"New features in this version";
        
        _infoViewOKButtonTitle = @"Okay";
        _infoViewContinueButtonTitle = @"Continue";
        _infoViewUpdateButtonTitle = @"Update";
        
        _infoViewBacgroundColor = [UIColor blackColor];
        _infoViewBacgroundAlpha = 0.85;
        
        _infoViewTitleColor = [UIColor andVersionGreen];
        _infoViewTitleFont = [UIFont fontWithName:AND_VERSION_FONT size:14];
        
        _infoViewTableSeperatorColor = [UIColor andVersionGreen];
        
        _infoViewOKButtonColor = [UIColor andVersionGreen];
        _infoViewOKButtonTextColor = [UIColor whiteColor];
        
        _infoViewUpdateButtonColor = [UIColor andVersionGreen];
        _infoViewUpdateButtonTextColor = [UIColor whiteColor];
        
        _infoViewContinueButtonColor = [UIColor andVersionRed];
        _infoViewContinueButtonTextColor = [UIColor whiteColor];
        
        _infoViewButtonFont = [UIFont fontWithName:AND_VERSION_FONT size:14];
        
        _infoViewWhatsNewTextColor = [UIColor whiteColor];
        _infoViewWhatsNewFont = [UIFont fontWithName:AND_VERSION_FONT size:12];
    }
    
    return self;
}


@end
