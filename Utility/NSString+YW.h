//
//  NSString+YW.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YW)
//获取当前的时间，转成字符串 格式默认为 yyyy-MM-dd
+ (NSString *)stringWithNowDate;
+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater;

- (NSString *) md5HexDigest; //md5加密
//转换文件大小成字符串,
//fileSize 单位：B   结果格式为 *.*G *.*M  ...
+ (NSString *)stringWithSize:(float)fileSize;

- (BOOL) isEmail ;
@end
