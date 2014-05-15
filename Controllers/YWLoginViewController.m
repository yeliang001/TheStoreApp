//
//  YMLoginViewController.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWLoginViewController.h"
#import "YWLoginCell.h"
#import "YWButton.h"
#import "YWCheckButton.h"
#import "YWRegistViewController.h"
 
@interface YWLoginViewController ()

@end

@implementation YWLoginViewController

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
    self.title = @"登录账户";
    
    _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.autoresizingMask = self.view.autoresizingMask;
    _tableView.backgroundView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    
    [self.view addSubview:_tableView];
    
    __weak YWLoginViewController *wself = self;
    [self createRightButtonItem:nil title:@"注册" completionHandler:^{
        YWRegistViewController *regist = [[YWRegistViewController alloc] initWithNibName:@"YWRegistViewController" bundle:nil];
        [wself.navigationController pushViewController:regist animated:YES];
    }];
     
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 1){
        
        YWLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YWLoginCell"];
        if (!cell) {
            
            cell = (YWLoginCell *)[YWLoginCell Cell];
            
        }
        cell.textField.delegate = self;
        if (indexPath.row == 0) {
            cell.textField.tag   = Tag_AccountTextField;
            cell.bgImageView.tag = Tag_AccountImageView;
            cell.thumb.tag       = Tag_AccountThumb;
            cell.thumb.image = [UIImage imageNamed:@"yw_profile_gray"];
            cell.textField.placeholder = @"邮箱/用户名";

        }else{
            cell.textField.tag   = Tag_PasswordTextField;
            cell.bgImageView.tag = Tag_PasswordImageView;
            cell.thumb.tag       = Tag_PasswordThumb;
            cell.thumb.image = [UIImage imageNamed:@"yw_password_gray"];
            cell.textField.placeholder = @"密码";
            cell.textField.secureTextEntry = YES;
        }
        
        cell.bgImageView.image = [[UIImage imageNamed:@"yw_tf_gray"] stretchableImageWithLeftCapWidth:10 topCapHeight:2];
        
        return cell;
        
    }else{
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            
        }
        
        if (indexPath.row == 2) {

            UILabel *autoLoginLabel = [YWViewUtils labelWithFrame:CGRectMake(35, 18, 200, 21) withTitle:@"自动登录" titleFontSize:SYSTEMFONT(14) textColor:[UIColor lightGrayColor] alignment:NSTextAlignmentLeft];
            YWCheckButton *checkBtn = [[YWCheckButton alloc] initWithFrame:CGRectMake(10, 20, 18, 18) completionBlock:^(BOOL checked) {
                NSLog(@"-----------------checked--------------%d \n\n",checked);
            }];
            checkBtn.checked = YES;
            [cell addSubview:checkBtn];
       
            [cell addSubview:autoLoginLabel];
        }
        if (indexPath.row == 3) {
            UIButton *loginBtn = [YWViewUtils buttonWithTitle:@"登录" frame:CGRectMake(10, 10, 300, 40) image:KDEFAULTBTN lightImage:KDEFAULTBTN];
            [loginBtn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:loginBtn];
        }
        if (indexPath.row == 4) {
            UIButton *qqBtn = [YWViewUtils buttonWithTitle:@"" frame:CGRectMake(10,20, 53, 53) image:IMAGENAMED(@"yw_qqlogin") lightImage:IMAGENAMED(@"yw_qqlogin")];
            [cell addSubview:qqBtn];
            
            UILabel *qqLabel = [YWViewUtils labelWithFrame:CGRectMake(10,73,53, 20) withTitle:@"QQ登录" titleFontSize:SYSTEMFONT(12) textColor:[UIColor darkGrayColor] alignment:NSTextAlignmentCenter];
             [cell addSubview:qqLabel];
            
            
            UIButton *alipayBtn = [YWViewUtils buttonWithTitle:@"" frame:CGRectMake(83,20, 53, 53) image:IMAGENAMED(@"yw_alipay") lightImage:IMAGENAMED(@"yw_alipay")];
            UILabel *alipayLabel = [YWViewUtils labelWithFrame:CGRectMake(73,73,73, 20) withTitle:@"支付宝登录" titleFontSize:SYSTEMFONT(12) textColor:[UIColor darkGrayColor] alignment:NSTextAlignmentCenter];
            
            [cell addSubview:alipayLabel];
            [cell addSubview:alipayBtn];
        }
        return cell;
    }
     
    return nil;
}
- (void)loginButtonClick{
    [self allEditActionsResignFirstResponder];
    
    if ([self.yw_username length] == 0) {
        
        [YWActionUtility showAlert:@"用户名或邮箱不能为空"];
        return;
    }else if([self.yw_password length] == 0){

        [YWActionUtility showAlert:@"密码不能为空"];
        return;
    }
    
    loginAction = [[YWLoginAction alloc] init];
    loginAction.m_delegate = self;
    [loginAction requestAction];
 
}
-(NSDictionary*)onRequestLoginAction{
    return @{@"username": self.yw_username,@"password":self.yw_password};
}
-(void)onResponseUserLoginSuccess{
        [YWActionUtility showAlert:@"登录成功"];
}
-(void)onResponseUserLoginFail{
    [YWActionUtility showAlert:@"登录失败"];
}
#pragma mark -------------  textField delegate -----------------

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self swichTextStatus:textField imageSuffix:@"blue"];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self swichTextStatus:textField imageSuffix:@"gray"];
    
    return YES;
}
/**
 *  切换输入框状态
 *
 *  @param textField 输入框
 */
-(void)swichTextStatus:(UITextField *)textField imageSuffix:(NSString *)suffix{

    if (textField.tag == Tag_AccountTextField) {
        self.yw_username       = textField.text;
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:Tag_AccountImageView];

        UIImageView *thumb     = (UIImageView *)[self.view viewWithTag:Tag_AccountThumb];

        imageView.image        = [[UIImage imageNamed:STRING_FORMAT(@"yw_tf_%@",suffix)] stretchableImageWithLeftCapWidth:10 topCapHeight:2];
        thumb.image            = [UIImage imageNamed:STRING_FORMAT(@"yw_profile_%@",suffix)];
    }else if (textField.tag == Tag_PasswordTextField){
        self.yw_password       = textField.text;

        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:Tag_PasswordImageView];

        UIImageView *thumb     = (UIImageView *)[self.view viewWithTag:Tag_PasswordThumb];

        imageView.image        = [[UIImage imageNamed:STRING_FORMAT(@"yw_tf_%@",suffix)] stretchableImageWithLeftCapWidth:10 topCapHeight:2];
        thumb.image            = [UIImage imageNamed:STRING_FORMAT(@"yw_password_%@",suffix)];
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
 
#pragma mark - PrivateMethod
- (void)allEditActionsResignFirstResponder{
    
    //邮箱/用户名
    [[self.view viewWithTag:Tag_AccountTextField] resignFirstResponder];
    //密码
    [[self.view viewWithTag:Tag_PasswordTextField] resignFirstResponder];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        return 93;
    }
    return 50;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
