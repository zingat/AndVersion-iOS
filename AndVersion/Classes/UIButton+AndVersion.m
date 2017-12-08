//
//  UIButton+AndVersion.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 08/12/2017.
//

#import "UIButton+AndVersion.h"

@implementation UIButton (AndVersion)

-(void) configureButton:(AndVersionConfiguration *) config{
    if(config.infoViewButtonRadius < 0 || config.infoViewButtonRadius > self.frame.size.height / 2){
        self.layer.cornerRadius = self.frame.size.height / 2;
    }else{
        self.layer.cornerRadius = config.infoViewButtonRadius;
    }
    
    self.titleLabel.font = config.infoViewButtonFont;
}

@end
