//
//  UIButton+AndVersion.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 08/12/2017.
//

#import <UIKit/UIKit.h>
#import "AndVersionConfiguration.h"

@interface UIButton (AndVersion)

-(void) configureButton:(AndVersionConfiguration *) config;

@end
