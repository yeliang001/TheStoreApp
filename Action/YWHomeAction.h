//
//  YWHomeAction.h
//  TheStoreApp
//
//  Created by YaoWang on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWBaseAction.h"
#import "YWHomePageData.h"
@protocol YWHomeActionDelegate

-(NSDictionary*)onRequestCouponListAction;

-(void)onResponseCouponListActionSuccess;

-(void)onResponseCouponListActionFail;

@end
@interface YWHomeAction : YWBaseAction
{
    
    ASIHTTPRequest *m_request;
    
    __weak id<YWHomeActionDelegate> m_delegate;
    NSMutableDictionary *tempHomeDataDic;
}

@property(nonatomic,weak)id<YWHomeActionDelegate> m_delegate;
//@property(nonatomic,strong) NSMutableArray*

/**
 *	@brief	发出请求
 *
 *	请求用户登陆
 */
-(void)requestAction;

/**
 *	@brief	请求成功
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFinishResponse:(ASIHTTPRequest*)request;
/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFailResponse:(ASIHTTPRequest*)request;


/**
 *获取首页的数据
 *得到轮播图的对象数组  楼层的对象数组
 *轮播图 数组中对应的对象为：SpecialRecommendInfo
 *楼层的对象：
 *AdFloorInfo对象有：head bigPage keyword head和bigPage是一个SpecialRecommendInfo keyword是SpecialRecommendInfo数组
 */
- (YWHomePageData *)getHomeSpcecialList;
@end
