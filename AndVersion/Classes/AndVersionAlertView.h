//
//  AndVersionAlertView.h
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 05/10/2017.
//

#import <UIKit/UIKit.h>

// NSParagraphStyle
typedef NS_ENUM(NSInteger, AndVersionAlertViewType) {
    AndVersionAlertViewTypeMandatoryUpdate = 0,
    AndVersionAlertViewTypeOptionalUpdate,
    AndVersionAlertViewTypeNewVersion
};

@interface AndVersionAlertView : UIAlertView

-(void) show:(AndVersionAlertViewType)andVersionAlertViewType whatsNew:(NSArray <NSString *> *) whatsNew;

@end
