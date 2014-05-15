//
//  YMViewUtils.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWViewUtils.h"

@implementation YWViewUtils
+ (AppDelegate *)applicationDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = textAlignment;
    return label;
    
}


+ (UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)btnFrame image:(UIImage *)image lightImage:(UIImage *)lightImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = btnFrame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:lightImage  forState:UIControlStateHighlighted];
    
    return btn;
}


@end
