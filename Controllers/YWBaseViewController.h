//
//  YWBaseViewController.h
//  TheStoreApp
//
//  Created by YaoWang on 14-5-12.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonHandler)(void);

typedef enum  {
    BaseVC_PushType       ,
    BaseVC_PresentType
    
}BaseVC_LoadType;

@interface YWBaseViewController : UIViewController

@property(nonatomic,copy)ButtonHandler buttonHander;

/**
 *  创建导航条右侧按钮
 *
 *  @param normalImagename   按钮名称
 *  @param highlighImagename 高亮按钮名称
 *  @param buttonTitle       按钮名称
 */

-(void)createRightButtonItem:(NSString *)buttonImage title:(NSString*)title completionHandler:(ButtonHandler)handler;



/** 视图控制器加载类型 */
@property (nonatomic,assign) BaseVC_LoadType loadType;

@property(nonatomic,strong)NSMutableArray *dataArray;

-(void)onButtonActionBack:(id)sender;
@end
