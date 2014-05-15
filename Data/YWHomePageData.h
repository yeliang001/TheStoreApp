//
//  Page.h
//  ProtocolDemo
//
//  Created by vsc on 11-1-30.
//  Copyright 2011 vsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWBaseData.h"
/* ###########################  要实现文件缓存需将objList对应的实体类实现<NSCoding>协议 ###############################*/
@interface YWHomePageData : YWBaseData <NSCoding>{
 @private
	NSNumber * currentPage;
	NSMutableArray * objList;
	NSNumber * pageSize;
	NSNumber * totalSize;
}
@property(strong,nonatomic)NSNumber         * currentPage;
@property(strong,nonatomic)NSMutableArray   * objList;
@property(strong,nonatomic)NSNumber         * pageSize;
@property(strong,nonatomic)NSNumber         * totalSize;

//首页中楼层广告数据，药店使用
@property (strong, nonatomic)NSMutableArray *adFloorList;


// extra
@property (strong) NSMutableDictionary      *userInfo;
@end

#define PAGE_USER_INFO_ORDER_TYPE   @"PAGE_USER_INFO_ORDER_TYPE"
