//
//  UILabel+Misc.m
//  AndVersion
//
//  Created by Kadir Kemal Dursun on 05/10/2017.
//

#import "UILabel+Misc.h"

@implementation UILabel (Misc)

-(CGFloat) calculateBesFitHeightForText{
    CGSize constraint = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [self.text boundingRectWithSize:constraint
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:self.font}
                                                 context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

-(void) fitText{
    CGRect rect = [self.text
                   boundingRectWithSize:self.frame.size
                   options:NSStringDrawingUsesLineFragmentOrigin
                   attributes:@{ NSFontAttributeName:self.font }
                   context:nil];
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, rect.size.width, rect.size.height);
}

@end
