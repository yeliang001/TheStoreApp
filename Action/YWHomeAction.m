//
//  YWHomeAction.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWHomeAction.h"
#import "YWSpecialRecommendInfoData.h"
#import "YWAdFloorInfoData.h"
@implementation YWHomeAction

@synthesize m_delegate;

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
    if (m_request !=nil && [m_request isFinished]) {
        return;
    }
    
    NSDictionary *l_dict_request = [m_delegate onRequestCouponListAction];
    
    m_request  = [[KDATAWORLD httpEngine] buildRequest:@"gethomepage"
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
    
    NSLog(@"-------------------------------%@ \n\n",l_dict_response);
    
    if ([YWActionUtility isRequestJSONSuccess:l_dict_response]) {
        
        if ([(UIViewController*)m_delegate  respondsToSelector:@selector(onResponseCouponListActionSuccess)]) {
            tempHomeDataDic = [l_dict_response objectForKey:@"data"];
            [m_delegate onResponseCouponListActionSuccess];
        }
        
    }else{
        
        if ([(UIViewController*)m_delegate  respondsToSelector:@selector(onResponseCouponListActionFail)]) {
            [m_delegate onResponseCouponListActionFail];
        }
    }
    
    m_request = nil;
}

- (YWHomePageData *)getHomeSpcecialList
{
    NSMutableArray *resultList = [[NSMutableArray alloc] init];

    NSDictionary *dataDic = tempHomeDataDic;
    NSArray *jiaoDianTuDic = dataDic[@"index_lb"];
    //        NSArray *specials = jiaoDianTuDic[@"specials"];
    for (NSDictionary *dic in jiaoDianTuDic)
    {
        YWSpecialRecommendInfoData *specialInfo = [[YWSpecialRecommendInfoData alloc] init];
        
        specialInfo.spaceCode = dic[@"spaceCode"];
        specialInfo.content = dic[@"content"];
        specialInfo.pic = dic[@"pic"];
        specialInfo.title = dic[@"title"];
        
        specialInfo.triggerType = [dic[@"triggerType"] intValue];
        specialInfo.platId = [dic[@"platId"] intValue];
        specialInfo.specialId = [dic[@"id"] intValue];
        specialInfo.areaId = [dic[@"areaId"] intValue];
        
        [resultList addObject:specialInfo];
    }
    
    //楼层广告
    NSMutableArray *adFloorList = [[NSMutableArray alloc] init];
    NSArray *floorArr = dataDic[@"index_lc"];
    for (NSDictionary *dic in floorArr)
    {
        YWAdFloorInfoData *floor = [[YWAdFloorInfoData alloc] init];
        
        /*加head图*/
        NSDictionary *headDic = dic[@"head"];
        YWSpecialRecommendInfoData *headInfo = [[YWSpecialRecommendInfoData alloc] init];
        headInfo.spaceCode = headDic[@"spaceCode"];
        headInfo.content = headDic[@"content"];
        headInfo.pic = headDic[@"pic"];
        headInfo.title = headDic[@"title"];
        headInfo.triggerType = [headDic[@"triggerType"] intValue];
        headInfo.platId = [headDic[@"platId"] intValue];
        headInfo.specialId = [headDic[@"id"] intValue];
        headInfo.areaId = [headDic[@"areaId"] intValue];
        floor.head = headInfo;
        
        /*加Big图*/
        NSDictionary *bigPageDic = dic[@"index_ggl_ggw_1"];
        YWSpecialRecommendInfoData *BigPageInfo = [[YWSpecialRecommendInfoData alloc] init];
        BigPageInfo.spaceCode = bigPageDic[@"spaceCode"];
        BigPageInfo.content = bigPageDic[@"content"];
        BigPageInfo.pic = bigPageDic[@"pic"];
        BigPageInfo.title = bigPageDic[@"title"];
        BigPageInfo.triggerType = [bigPageDic[@"triggerType"] intValue];
        BigPageInfo.platId = [bigPageDic[@"platId"] intValue];
        BigPageInfo.specialId = [bigPageDic[@"id"] intValue];
        BigPageInfo.areaId = [bigPageDic[@"areaId"] intValue];
        floor.bigPage = BigPageInfo;
        
        
        NSArray *keywordArr = dic[@"keyword"];
        
        NSMutableArray *productListInAd = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in keywordArr)
        {
            YWSpecialRecommendInfoData *keywordInfo = [[YWSpecialRecommendInfoData alloc] init];
            keywordInfo.spaceCode = dic[@"spaceCode"];
            keywordInfo.content = dic[@"content"];
            keywordInfo.pic = dic[@"pic"];
            keywordInfo.title = dic[@"title"];
            
            keywordInfo.triggerType = [dic[@"triggerType"] intValue];
            keywordInfo.platId = [dic [@"platId"] intValue];
            keywordInfo.specialId = [dic[@"id"] intValue];
            keywordInfo.areaId = [dic[@"areaId"] intValue];

            [productListInAd addObject:keywordInfo];
        }
       
        floor.productList = productListInAd;
        
        [adFloorList addObject:floor];
    }
    YWHomePageData *page = [[YWHomePageData alloc] init];
    page.objList = resultList;
    page.adFloorList = adFloorList;
    return page;

}

/**
 *	@brief	请求失败
 *
 *	回调函数
 *
 *	@param 	request 	请求对象
 */
-(void)onRequestFailResponse:(ASIHTTPRequest*)request{
    
    if ([(UIViewController*)m_delegate  respondsToSelector:@selector(onResponseCouponListActionFail)]) {
        [m_delegate onResponseCouponListActionFail];
    }
    m_request = nil;
}


@end
