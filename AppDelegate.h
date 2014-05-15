//
//  AppDelegate.h
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RDVTabBarController *tabBarController;

@end
