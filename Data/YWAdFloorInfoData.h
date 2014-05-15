//
//  AdFloorInfo.h
//  TheStoreApp
//
//  Created by LinPan on 13-7-29.
//
//  首页楼层广告类的model

#import <Foundation/Foundation.h>
#import "YWBaseData.h"
#import "YWSpecialRecommendInfoData.h"

@interface YWAdFloorInfoData : YWBaseData<NSCoding>


@property(strong,nonatomic) YWSpecialRecommendInfoData *head;
@property(strong,nonatomic) YWSpecialRecommendInfoData *bigPage;
@property(strong, nonatomic) NSMutableArray *productList;
@property(strong, nonatomic) NSArray *keywordList;

@end
