//
//  YMViewUtils.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface YWViewUtils : NSObject

+(AppDelegate *)applicationDelegate;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image;

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color alignment:(NSTextAlignment)textAlignment;
 
+ (UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)btnFrame image:(UIImage *)image lightImage:(UIImage *)lightImage;

@end
