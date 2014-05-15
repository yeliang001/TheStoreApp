//
//  AppDelegate.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "AppDelegate.h"
#import "YWHomeViewController.h"
#import "YWCategoryViewController.h"
#import "YWCartViewController.h"
#import "YWAccountViewController.h"

#import "RDVTabBarItem.h"

#define KAPPIMAGE [[UIImage imageNamed:@"tabbarBg"] stretchableImageWithLeftCapWidth:5 topCapHeight:5]

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
     
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    
    [self setupViewControllers];
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
    return YES;
}


#pragma mark - Methods

- (void)setupViewControllers {
    
    
    YWHomeViewController *homeVC = [[YWHomeViewController alloc] initWithNibName:@"YWHomeViewController" bundle:nil];
    YWCategoryViewController *categoryVC = [[YWCategoryViewController alloc] initWithNibName:@"YWCategoryViewController" bundle:nil];
    YWCartViewController *cartVC = [[YWCartViewController alloc] initWithNibName:@"YWCartViewController" bundle:nil];
    YWAccountViewController *accoutVC = [[YWAccountViewController alloc] initWithNibName:@"YWAccountViewController" bundle:nil];
    
    UINavigationController *nav_home = [[UINavigationController alloc] initWithRootViewController:homeVC];
    nav_home.delegate = self;
    UINavigationController *nav_category = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    nav_category.delegate = self;
    UINavigationController *nav_cart = [[UINavigationController alloc] initWithRootViewController:cartVC];
    nav_cart.delegate = self;
    UINavigationController *nav_account = [[UINavigationController alloc] initWithRootViewController:accoutVC];
    nav_account.delegate = self;
    
    
    _tabBarController = [[RDVTabBarController alloc] init];
    [_tabBarController setViewControllers:@[nav_home,nav_category,nav_cart,nav_account]];
    [_tabBarController setSelectedIndex:0];
    
    
    [self customizeTabBarForController:_tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    NSArray *tabBarItemImages = @[@"yw_home", @"yw_category", @"yw_cart",@"yw_account"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:KAPPIMAGE withUnselectedImage:KAPPIMAGE];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    RDVTabBarController *tabBarController = self.tabBarController;
    
    if (navigationController.viewControllers.count > 1) {
        
        [tabBarController setTabBarHidden:YES animated:YES];
    } else {
        
        [tabBarController setTabBarHidden:NO animated:YES];
    }
    
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        return;
    } else {
        [navigationBarAppearance setBackgroundImage:KAPPIMAGE
                                      forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *textAttributes = nil;
        
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            textAttributes = @{
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                               NSForegroundColorAttributeName: [UIColor blackColor],
                               };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            textAttributes = @{
                               UITextAttributeFont: [UIFont boldSystemFontOfSize:16],
                               UITextAttributeTextColor: [UIColor blackColor],
                               UITextAttributeTextShadowColor: [UIColor clearColor],
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
#endif
        }
        
        [navigationBarAppearance setTitleTextAttributes:textAttributes];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
