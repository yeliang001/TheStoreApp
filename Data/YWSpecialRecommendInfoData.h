//
//  SpecialRecommendInfo.h
//  TheStoreApp
//
//  Created by YaoWang on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWBaseData.h"
@interface YWSpecialRecommendInfoData : YWBaseData<NSCoding>

@property (strong, nonatomic) NSString *spaceCode;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *pic;
@property (strong, nonatomic) NSString *title;

@property (assign, nonatomic) int triggerType;
@property (assign, nonatomic) int platId;
@property (assign, nonatomic) int specialId;//id
@property (assign, nonatomic) int areaId;

@end
