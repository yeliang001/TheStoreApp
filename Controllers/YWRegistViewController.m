//
//  YWRegistViewController.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWRegistViewController.h"
#import "YWLoginCell.h"
#import "YWCheckButton.h"
#import "NSString+YW.h"
@interface YWRegistViewController ()

@end

@implementation YWRegistViewController

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
    self.title = @"注册账户";
    self.titleArray = @[@"请使用字母和数字",@"请输入常用邮箱",@"6-20位字母、数字或符号组合"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
        
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
         
        }else if (indexPath.row == 1) {
            
            cell.textField.tag   = Tag_EmailTextField;
            cell.bgImageView.tag = Tag_EmailImageView;
            cell.thumb.tag       = Tag_EmailThumb;
            cell.thumb.image     = [UIImage imageNamed:@"yw_email_gray"];
           
        }else{
            cell.textField.tag   = Tag_PasswordTextField;
            cell.bgImageView.tag = Tag_PasswordImageView;
            cell.thumb.tag       = Tag_PasswordThumb;

            cell.thumb.image     = [UIImage imageNamed:@"yw_password_gray"];
               cell.textField.secureTextEntry = YES;
        }
        
         cell.textField.placeholder = _titleArray[indexPath.row];
        
        cell.bgImageView.image = [[UIImage imageNamed:@"yw_tf_gray"] stretchableImageWithLeftCapWidth:10 topCapHeight:2];
        
        return cell;
        
    }else{
        static NSString *CellIdentifier = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
     
        if (indexPath.row == 3) {
            UILabel *agreementLabel = [YWViewUtils labelWithFrame:CGRectMake(35, 18, 200, 21) withTitle:@"同意《壹药网协议》" titleFontSize:SYSTEMFONT(14) textColor:[UIColor lightGrayColor] alignment:NSTextAlignmentLeft];
            YWCheckButton *agreementBtn = [[YWCheckButton alloc] initWithFrame:CGRectMake(10, 20, 18, 18) completionBlock:^(BOOL checked) {
             }];
            agreementBtn.checked = YES;
            
            __weak YWRegistViewController *wself = self;
            UILabel *revealPwdLabel = [YWViewUtils labelWithFrame:CGRectMake(253, 18, 200, 21) withTitle:@"显示密码" titleFontSize:SYSTEMFONT(14) textColor:[UIColor lightGrayColor] alignment:NSTextAlignmentLeft];
            YWCheckButton *revealPwdBtn = [[YWCheckButton alloc] initWithFrame:CGRectMake(230, 20, 18, 18) completionBlock:^(BOOL checked) {

                [wself allEditActionsResignFirstResponder];
                UITextField *textField = (UITextField *)[wself.view viewWithTag:Tag_PasswordTextField];
                textField.secureTextEntry = !checked;
            
            }];
            
            [cell addSubview:revealPwdBtn];
            [cell addSubview:revealPwdLabel];
            [cell addSubview:agreementBtn];
            [cell addSubview:agreementLabel];

        }
        if (indexPath.row == 4) {
            
            UIButton *loginBtn = [YWViewUtils buttonWithTitle:@"注册" frame:CGRectMake(10, 10, 300, 40) image:KDEFAULTBTN lightImage:KDEFAULTBTN];
            [loginBtn addTarget:self action:@selector(registButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:loginBtn];
             
        }
        return cell;
    }
    
    return nil;
}
#pragma mark ------------- 注册 -----------------

-(void)registButtonClick{
    [self allEditActionsResignFirstResponder];
 
    
    if ([self.yw_username length] == 0) {
        
        [YWActionUtility showAlert:@"用户名不能为空"];
        return;
    }else if([self.yw_email length] == 0){
        [YWActionUtility showAlert:@"邮箱不能为空"];
    }else if(![self.yw_email isEmail]){
        [YWActionUtility showAlert:@"邮箱格式不正确"];
        return;
    }else if([self.yw_password length] < 6 || [self.yw_password length] >20){
        
        [YWActionUtility showAlert:@"密码位数不正确"];
        return;
    }

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
    
    if (textField.tag == Tag_EmailTextField){
        self.yw_email          = textField.text;

        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:Tag_EmailImageView];

        UIImageView *thumb     = (UIImageView *)[self.view viewWithTag:Tag_EmailThumb];

        imageView.image        = [[UIImage imageNamed:STRING_FORMAT(@"yw_tf_%@",suffix)] stretchableImageWithLeftCapWidth:10 topCapHeight:2];
        thumb.image            = [UIImage imageNamed:STRING_FORMAT(@"yw_email_%@",suffix)];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}


#pragma mark - PrivateMethod
- (void)allEditActionsResignFirstResponder{
    
    //用户名
    [[self.view viewWithTag:Tag_AccountTextField] resignFirstResponder];
    //密码
    [[self.view viewWithTag:Tag_PasswordTextField] resignFirstResponder];
    //邮箱
    [[self.view viewWithTag:Tag_EmailTextField] resignFirstResponder];
    
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
