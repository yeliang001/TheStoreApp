//
//  YWCheckButton.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWCheckButton.h"

#define YW_CHECK_ICON_WH                    (18.0)
#define YW_ICON_TITLE_MARGIN                (5.0)

@implementation YWCheckButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame completionBlock:(YWCheckButtonBlock )block{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        [self setImage:IMAGENAMED(@"yw_cart_uncheck") forState:UIControlStateNormal];
        [self setImage:IMAGENAMED(@"yw_account_checked") forState:UIControlStateSelected];
        
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
        
        self.completionBlock = block;
    }
    return self;
}


- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (self.completionBlock) {
        self.completionBlock(_checked);
    }
}

- (void)checkboxBtnChecked {
    self.selected = !self.selected;
    _checked = self.selected;
    
    if (self.completionBlock) {
        self.completionBlock(_checked);
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, (CGRectGetHeight(contentRect) - YW_CHECK_ICON_WH)/2.0, YW_CHECK_ICON_WH, YW_CHECK_ICON_WH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(YW_CHECK_ICON_WH + YW_ICON_TITLE_MARGIN, 0,
                      CGRectGetWidth(contentRect) - YW_CHECK_ICON_WH - YW_ICON_TITLE_MARGIN,
                      CGRectGetHeight(contentRect));
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
