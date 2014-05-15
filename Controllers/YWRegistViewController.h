//
//  YWRegistViewController.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWBaseViewController.h"

@interface YWRegistViewController : YWBaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic, copy) NSString *yw_username;
@property (nonatomic, copy) NSString *yw_password;
@property (nonatomic, copy) NSString *yw_email;
@end
