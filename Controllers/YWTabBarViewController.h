//
//  YWTabBarViewController.h
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-22.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWTabBarViewController : UITabBarController
{
    NSMutableArray *imgArray;
    NSMutableArray *selImgArray;
    NSMutableArray *tabViews;
    NSInteger currentIndex;
}

-(void)selectItemAtIndex:(NSInteger)index;
@end
