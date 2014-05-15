//
//  YMLoginViewController.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWBaseViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "YWLoginAction.h"
@interface YWLoginViewController : YWBaseViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,YWLoginActionDelegate>{
    YWLoginAction *loginAction;
}
 
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, copy) NSString *yw_username;
@property (nonatomic, copy) NSString *yw_password;

@end
