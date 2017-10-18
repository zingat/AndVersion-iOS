//
//  Configuration.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 18/10/2017.
//

#import "AndVersionConfiguration.h"

@implementation AndVersionConfiguration

-(instancetype)init{
    self = [super init];
    if(self){
        _titleForNeedUpdate = @"It is recommended to update your applciation";
        _titleForNewVersion = @"New features in this version";
        _okButtonTitle = @"Okay";
        _continueButtonTitle = @"Continue";
        _updateButtonTitle = @"Update";
        
        _alertviewBacgroundColor = [UIColor blackColor];
        _alertviewBacgroundAlpha = 0.85;
    }
    
    return self;
}


@end
