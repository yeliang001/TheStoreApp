//
//  YWStringUtility.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWStringUtility.h"

@implementation YWStringUtility

@end



inline NSString* strOrEmpty(NSString * str){
   
    if ([str isEqual:[NSNull null]]) {
         return  @"";
    }
 
	return (str==nil?@"":str);
}
