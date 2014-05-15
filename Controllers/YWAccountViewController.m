//
//  YWMyAccountViewController.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWAccountViewController.h"
#import "YWLoginViewController.h"
@interface YWAccountViewController ()

@end

@implementation YWAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的药店";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    YWLoginViewController *login = [[YWLoginViewController alloc] init];
    login.loadType = BaseVC_PresentType;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];

    [self presentViewController:nav animated:YES completion:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItems = nil;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
