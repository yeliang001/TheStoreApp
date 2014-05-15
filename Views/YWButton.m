//
//  YWButton.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWButton.h"

@implementation YWButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commitInit];
        
    }
    return self;
}
-(void)commitInit{
   
    [self setBackgroundImage:[[UIImage imageNamed:@"yw_loginBtn"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [self setBackgroundImage:[[UIImage imageNamed:@"yw_loginBtn"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];
    

}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commitInit];
    }
    
    return self;
    
}
- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
