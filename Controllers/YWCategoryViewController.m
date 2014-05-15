//
//  YWCategoryViewController.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWCategoryViewController.h"

@interface YWCategoryViewController ()

@end

@implementation YWCategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"分类";
    }
    return self;
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
