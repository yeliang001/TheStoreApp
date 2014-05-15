//
//  YWCheckButton.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YWCheckButtonBlock)(BOOL checked);

@interface YWCheckButton : UIButton{
   

}
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, strong)id userInfo;

@property(nonatomic, copy) YWCheckButtonBlock completionBlock;


- (id)initWithFrame:(CGRect)frame completionBlock:(YWCheckButtonBlock )block;
@end
