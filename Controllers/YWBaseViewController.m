//
//  YWBaseViewController.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWBaseViewController.h"

@interface YWBaseViewController ()

@end

@implementation YWBaseViewController

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
 
 
//  [self.navigationController setNavigationBarHidden:YES animated:NO];
  
  
    [self createBackButton];
 
}
-(void)createRightButtonItem:(NSString *)buttonImage title:(NSString*)title completionHandler:(ButtonHandler)handler{
    self.buttonHander = handler;
    
    UIButton *rightBtn = [YWViewUtils buttonWithTitle:title frame:CGRectMake(50, 0, 50, 44) image:IMAGENAMED(buttonImage) lightImage:IMAGENAMED(buttonImage)];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:BOLDSYSTEMFONT(16)];

    [rightBtn addTarget:self action:@selector(onRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView* rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,100,44)];
    
    [rightView addSubview:rightBtn];
    
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [self addRightBarButtonItem:rightButtonItem];
}
-(void)onRightButtonAction:(id)sender{
    if (self.buttonHander) {
        self.buttonHander();
    }
}
/**
 *  创建自定义返回按钮
 */
-(void)createBackButton{
    
    UIImage *backImage=[UIImage imageNamed:@"yw_backBg.png"];
    
    UIButton *l_btn_back = [UIButton buttonWithType:UIButtonTypeCustom];
    l_btn_back.frame = CGRectMake(5,22 - backImage.size.height/4, backImage.size.width/2, backImage.size.height/2);
    [l_btn_back setImage:backImage forState:UIControlStateNormal];
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(backImage.size.width/2 + 2 + 5, 0, 40, 44);
    [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [titleBtn.titleLabel setFont:BOLDSYSTEMFONT(16)];
    [titleBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    
    [titleBtn addTarget:self action:@selector(onButtonActionBack:) forControlEvents:UIControlEventTouchUpInside];
    [l_btn_back addTarget:self action:@selector(onButtonActionBack:) forControlEvents:UIControlEventTouchUpInside];
 
 	UIView* backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,80, 44)];
    [backView addSubview:titleBtn];
    [backView addSubview:l_btn_back];
 
     
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
    [self addLeftBarButtonItem:leftButtonItem];
    
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        negativeSpacer.width = -10;
    } else {
        
        negativeSpacer.width = 0;
        
    }
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil]];
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        negativeSpacer.width = -10;
        
    } else {
        negativeSpacer.width = 0;
    }
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil]];
}
#pragma -
#pragma mark 返回上一个视图
-(void)onButtonActionBack:(id)sender{
    
    if (BaseVC_PresentType == self.loadType)
    {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}
//
//-(void)SetSubViewExternNone:(UIViewController *)viewController
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//    if (IsIOS7)
//    {
//        
//        viewController.edgesForExtendedLayout = UIRectEdgeNone;
//        
//        //        viewController.automaticallyAdjustsScrollViewInsets = YES;
//        viewController.extendedLayoutIncludesOpaqueBars = NO;
//        viewController.modalPresentationCapturesStatusBarAppearance = NO;
//        viewController.navigationController.navigationBar.translucent = NO;
//        
//    }
//#endif  // #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//}


//#pragma mark - 适配ios7
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//
//- (void) viewDidLayoutSubviews
//{
//    if (ISIOS7)
//    {
//        CGRect viewBounds = self.view.bounds;
//        CGFloat topBarOffset = self.topLayoutGuide.length;
//        viewBounds.origin.y = topBarOffset * -1;
//        self.view.bounds = viewBounds;
//    }
//}
//#endif

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
