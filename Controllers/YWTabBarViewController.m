//
//  YWTabBarViewController.m
//  YaoWangNewPro
//
//  Created by 林盼 on 14-3-22.
//  Copyright (c) 2014年 林盼. All rights reserved.
//

#import "YWTabBarViewController.h"

@interface YWTabBarViewController ()

@end

@implementation YWTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    
    
    int vcCount = [self.viewControllers count];
    
    imgArray=[[NSMutableArray alloc] initWithCapacity:vcCount];
    selImgArray=[[NSMutableArray alloc] initWithCapacity:vcCount];
    tabViews = [[NSMutableArray alloc] initWithCapacity:vcCount];
    
    [imgArray addObject:[UIImage imageNamed:@"tabbar_homepage_unsel.png"]];
    [imgArray addObject:[UIImage imageNamed:@"tabbar_category_unsel.png"]];
    [imgArray addObject:[UIImage imageNamed:@"tabbar_cart_unsel.png"]];
    [imgArray addObject:[UIImage imageNamed:@"tabbar_store_unsel.png"]];
    
    
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_homepage_sel.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_category_sel.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_cart_sel.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_store_sel.png"]];
//
//    
// 
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_home_selected.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_category_selected.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_cart_selected.png"]];
//    [selImgArray addObject:[UIImage imageNamed:@"tabbar_account_selected.png"]];
 
    [selImgArray addObject:[UIImage imageNamed:@"tabbar_homepage_sel.png"]];
    [selImgArray addObject:[UIImage imageNamed:@"tabbar_category_sel.png"]];
    [selImgArray addObject:[UIImage imageNamed:@"tabbar_cart_sel.png"]];
    [selImgArray addObject:[UIImage imageNamed:@"tabbar_store_sel.png"]];
 
    
    
    for (int i=0; i < vcCount; i++)
    {
        NSLog(@"self.tabBar.subviews  %@",self.tabBar.subviews);
        
        UIView *subView=[self.tabBar.subviews objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] init];
        if (ISIOS7) {
            imgView.frame = CGRectMake(0, 0, 64, 50);
        }else
            imgView.frame = CGRectMake(80*i, 0, 64, 50);
        [imgView setImage:[imgArray objectAtIndex:i]];
        [subView addSubview:imgView];
        [tabViews addObject:imgView];
    }
    
    if (tabViews.count > 0)
    {
        currentIndex = 0;
        [[tabViews objectAtIndex:currentIndex] setImage:[selImgArray objectAtIndex:0]];
    }
    [[self tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"transparent.png"]];
}


-(UIImageView*)customViewForIndex:(NSUInteger)aIndex
{
    return (UIImageView*)[tabViews objectAtIndex:aIndex];
}

-(void)selectItemAtIndex:(NSInteger)index
{
    if (currentIndex == index)
    {
        return;
    }
    
    [[self customViewForIndex:currentIndex] setImage:[imgArray objectAtIndex:currentIndex]];
    [[self customViewForIndex:index] setImage:[selImgArray objectAtIndex:index]];
    
    currentIndex = index;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
