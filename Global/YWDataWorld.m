//
//  YWDataWorld.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWDataWorld.h"

static YWDataWorld *sharedObj = nil; //第一步：静态实例，并初始化。

@implementation YWDataWorld

+ (YWDataWorld*) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj =  [[self alloc] init];
        }
    }
    return sharedObj;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}


- (YWHttpEngine *)httpEngine{
    @synchronized(self)
	{
        
		if (m_httpEngine==nil)
		{
			m_httpEngine = [YWHttpEngine engineWithHeaderParams:nil];
            [m_httpEngine setM_timeInterval_timeout:15.0f];
		}
	}
	return m_httpEngine;
}

@end
