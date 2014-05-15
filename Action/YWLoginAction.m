//
//  MLoginAction.m
//  MrMoney
//
//  Created by xingyong on 13-12-9.
//  Copyright (c) 2013年 xingyong. All rights reserved.
//

#import "YWLoginAction.h"
#import "YWMapper.h"
#import "YWUserData.h"

@implementation YWLoginAction
@synthesize m_delegate ;

-(void)dealloc{
    m_delegate  = nil;
    [m_request  clearDelegatesAndCancel];
}

/**
 *	@brief	发出请求
 *
 *	请求用户登陆
 */
-(void)requestAction{
    if (m_request !=nil && [m_request  isFinished]) {
        return;
    }
    
    NSDictionary *l_dict_request = [m_delegate onRequestLoginAction];
    
    m_request  = [[KDATAWORLD httpEngine] buildRequest:@"customer.login"
                                            postParams:l_dict_request
                                                object:self
                                      onFinishedAction:@selector(onRequestFinishResponse:)
                                        onFailedAction:@selector(onRequestFailResponse:)];
    
    [m_request startAsynchronous];
}

/**
 *	@brief	请求成功
 *
 *	回调函数
 *	@param 	request 	请求对象
 */
-(void)onRequestFinishResponse:(ASIHTTPRequest*)request{
    NSString *l_str_response=[request responseString];
    
    NSDictionary *l_dict_response=[l_str_response objectFromJSONString];
    
     DebugLog(@"登录返回 -------- %@",l_dict_response);
    
 
    NSString *statusCode = l_dict_response[@"statuscode"];
    
    if ([statusCode intValue] !=200) {
        [YWActionUtility showAlert:@"登录失败" message:l_dict_response[@"description"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
 
    }else{
       
        NSDictionary *customer_dict = [[[l_dict_response objectForKey:@"data"] objectForKey:@"user"] objectForKey:@"customer"];
 
        YWUserData *user = [YWMapper objectWithClass:[YWUserData class] fromDictionary:customer_dict];
        
        
        NSLog(@"----------------------name---------%@ \n\n",user.mname);
        
    }
 
    m_request = nil;
}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFailResponse:(ASIHTTPRequest*)request{
    if ([(UIViewController*)m_delegate  respondsToSelector:@selector(onResponseUserLoginFail)]) {
        [m_delegate  onResponseUserLoginFail];
    }
    m_request =nil;
}
@end
