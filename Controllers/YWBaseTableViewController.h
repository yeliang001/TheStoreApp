//
//  MBaseTableViewController.h
//  MrMoney
//
//  Created by xingyong on 14-3-24.
//  Copyright (c) 2014年 xingyong. All rights reserved.
//

#import "YWBaseViewController.h"

@interface YWBaseTableViewController : YWBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, readwrite) UITableViewStyle tableViewStyle;

- (void)setTableDataArray:(NSArray *)items;

@end
