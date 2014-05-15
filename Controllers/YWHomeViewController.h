//
//  YWHomeViewController.h
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWBaseViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "YWHomeHotPageView.h"
#import "YWHomeAction.h"
#import "YWHomePageData.h"
#import "YWHomePageModelACell.h"
@interface YWHomeViewController : YWBaseViewController<UIScrollViewDelegate,EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate,YWHomeActionDelegate,HomePageModelACellDelegate>
{
    YWHomeHotPageView *m_PageView;                                //焦点图页面
    EGORefreshTableHeaderView *m_RefreshHeaderView;         //下拉刷新控件
    BOOL isRefreshingHotPage;
    YWHomeAction *homeAction;
    
    YWHomePageData *hotTopPage;                                   //热销图
    
    NSMutableArray *m_AdArray;
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *main_ScrollView;
@property (strong, nonatomic) UITableView* modelATable;
@end
