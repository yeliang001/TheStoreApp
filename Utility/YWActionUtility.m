//
//  MActionUtility.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWActionUtility.h"
#import <netinet/in.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <sys/sysctl.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "NSString+YW.h"

#define kVenderId @"2011102716210000"
#define KAppKey @"3452AB32D98C987E798E010D798E010D"

static UIAlertView *_alertView = nil;

@implementation YWActionUtility

//adult.articles.get

//NSDictionary *paramDic = @{@"provinceid":pid};

+ (NSString *)getRequestUrlWithMethod:(NSString *)method
{
    //测试时，在这里os和sign里面的os都改成android，因为李丽这边iphone数据还没有配 已经okk
    NSString *timeReq = [NSString stringWithDate:[NSDate date] formater:@"yyyyMMddHHmmss"];
    NSString *unCodedSign = [NSString stringWithFormat:@"os=iphone&timestamp=%@&appkey=%@",timeReq,KAppKey];
    DebugLog(@"unCodedSign %@",unCodedSign);
    NSString *sign = [unCodedSign md5HexDigest];
    DebugLog(@"codedSign %@",sign);
    //测试服务器
    NSString *ceshiUrlString = [NSString stringWithFormat:@"http://192.168.89.18:19121/ApiControl?sign=%@&timestamp=%@&os=iphone&venderId=%@&method=%@&signMethod=md5&format=json&type=mobile&homepageversion=2",sign,timeReq,kVenderId,method];
    //李丽服务器
//    NSString *liLiUrlString = [NSString stringWithFormat:@"http://192.168.90.108/mobile-web/ApiControl?sign=%@&timestamp=%@&os=iphone&venderId=%@&method=%@&signMethod=md5&format=json&type=mobile&homepageversion=2",sign,timeReq,kVenderId,method];
//    //生产服务器 mobi.111.com.cn  ip = 101.226.186.3:8080
//    NSString *urlString = [NSString stringWithFormat:@"http://mobi.111.com.cn/ApiControl?sign=%@&timestamp=%@&os=iphone&venderId=%@&method=%@&signMethod=md5&format=json&type=mobile",sign,timeReq,kVenderId,method/*,[GlobalValue getGlobalValueInstance].provinceId*/];
//    //预生产
//    NSString *preUrlString = [NSString stringWithFormat:@"http://101.226.186.59/ApiControl?sign=%@&timestamp=%@&os=iphone&venderId=%@&method=%@&signMethod=md5&format=json&type=mobile",sign,timeReq,kVenderId,method/*,[GlobalValue getGlobalValueInstance].provinceId*/];
    
//    if ([GlobalValue getGlobalValueInstance].hostIndex == 0)
//    {
//        //0－>生产服务器
//        DebugLog(@"URL-> %@",urlString);
//        //        return urlString;
//        return ceshiUrlString;
//    }
//    else if ([GlobalValue getGlobalValueInstance].hostIndex == 1)
//    {
//        DebugLog(@"URL-> %@",ceshiUrlString);
//        return ceshiUrlString;
//    }
//    else if ([GlobalValue getGlobalValueInstance].hostIndex == 2)
//    {
//        DebugLog(@"URL-> %@",liLiUrlString);
//        return liLiUrlString;
//    }
//    else if ([GlobalValue getGlobalValueInstance].hostIndex == 3)
//    {
//        return preUrlString;
//    }
    
    return ceshiUrlString;
}

 

+ (void)showAlert:(NSString *)message{
    [[self class] showAlert:@""  message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
}
+ (void)showAlert:(NSString *)aTitle message:(NSString *)aMessage delegate:(id<UIAlertViewDelegate>)aDelegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    if (_alertView.isVisible) {
        return;
    }
    if (_alertView != nil) {
        _alertView = nil;
    }
    _alertView = [[UIAlertView alloc] initWithTitle:aTitle message:aMessage delegate:aDelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (otherButtonTitles != nil) {
        va_list args;
        va_start(args, otherButtonTitles);
        NSString* arg = nil;
        [_alertView addButtonWithTitle:otherButtonTitles];
        while ( ( arg = va_arg( args, NSString*) ) != nil ) {
            [_alertView addButtonWithTitle:arg];
        }
        va_end(args);
    }
    [_alertView show];
}

/**
 *	@brief	判断是否有网络
 *	@return
 */
+(BOOL)isNetworkReachable{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestJSONSuccess:(NSDictionary*)jsonDict{
    
    BOOL isSuccess = YES;
	if (jsonDict==nil) { // 网络错误
        
        if (![[self class] isNetworkReachable]){
            [[self class] showAlert:@"网络连接失败，请确保设备已经连网"];
 
        }else{
            [[self class] showAlert:@"当前网络不可用，请检查你的网络设置"];
          
        }
        isSuccess = NO;
	}else{
        
        NSString *resultCode = [jsonDict objectForKey:@"statuscode"];
        
        if ([resultCode intValue] != 200 ) {
            
            [[self class] showAlert:@"服务器异常"];
           
            isSuccess = NO;
        }
        
    }
	return isSuccess;
}

/**
 *	@brief 判断请求JSON是否成功
 *	失败时通知请求失败
 */
+(BOOL)isRequestNoAlertJSONSuccess:(NSDictionary*)jsonDict{
    
    BOOL isSuccess = YES;
    //	if (jsonDict==nil) { // 网络错误
    //
    //        isSuccess = NO;
    //	}else{
    //        QMResultData* _data = [[[QMResultData alloc] init] autorelease];
    //
    //        _data.mresultCode=[jsonDict objectForKey:@"ResultCode"];
    //        _data.mresultMsg=[jsonDict objectForKey:@"ResultMsg"];
    //
    //        if (![_data.mresultCode isEqualToString:@"0"]) {
    //            isSuccess = NO;
    //        }
    //    }
	return isSuccess;
}

@end
