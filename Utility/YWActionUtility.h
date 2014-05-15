//
//  MActionUtility.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWActionUtility : NSObject

/**
 *  返回服务地址
 *
 *  @param method 请求方法名
 *
 *  @return 请求地址
 */
+ (NSString *)getRequestUrlWithMethod:(NSString *)method;


+ (void)showAlert:(NSString *)message;

+ (void)showAlert:(NSString *)aTitle message:(NSString *)aMessage delegate:(id<UIAlertViewDelegate>)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;//显示alert

/**
 *	@brief	判断是否有网络
 *	@return
 */
+(BOOL)isNetworkReachable;

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestJSONSuccess:(NSDictionary*)jsonDict;

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestNoAlertJSONSuccess:(NSDictionary*)jsonDict;

@end
