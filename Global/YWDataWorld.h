//
//  YWDataWorld.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YWHttpEngine.h"

#define KDATAWORLD [YWDataWorld sharedInstance]

@interface YWDataWorld : NSObject{
    YWHttpEngine *m_httpEngine;
}

+ (YWDataWorld*) sharedInstance;

// 服务器Http请求引擎
- (YWHttpEngine *)httpEngine;

@end
