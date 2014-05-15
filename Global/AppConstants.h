//
//  AppConstants.h
//  TheStoreApp
//
//  Created by xingyong on 14-5-14.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#ifndef TheStoreApp_AppConstants_h
#define TheStoreApp_AppConstants_h

#ifndef IsIOS7
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#endif

#define NUMBER_INT(value) (value ? [NSNumber numberWithInt:value] : [NSNumber numberWithInt:0])
#define NUMBER_FLOAT(value) (value ? [NSNumber numberWithDouble:(double)value] : [NSNumber numberWithDouble:(double)0.0])
#define NUMBER_BOOL(value) (value ? [NSNumber numberWithBool:value] : [NSNumber numberWithBool:NO])
 
#define URL(__url) [NSURL URLWithString:__url]

#define SAFE_OBJECT(obj) ((NSNull *)(obj) == [NSNull null] ? nil : (obj))


#define STRING_FORMAT(...) [NSString stringWithFormat: __VA_ARGS__]


///////////////////////////////////////////////////////
#pragma mark - 消息中心
#define OUO_NOTIFICATIONCENTER [NSNotificationCenter defaultCenter]
#define OUO_NOTIFICATIONCENTER_ADD(n,sel) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:n object:nil];
#define OUO_NOTIFICATIONCENTER_REMOVE [[NSNotificationCenter defaultCenter] removeObserver:self];
#define OUO_NOTIFICATIONCENTER_POST(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];




#define user_defaults_get_bool(key)   [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define user_defaults_get_int(key)    ((int) [[NSUserDefaults standardUserDefaults] integerForKey:key])
#define user_defaults_get_double(key) [[NSUserDefaults standardUserDefaults] doubleForKey:key]
#define user_defaults_get_string(key) m_safeString([[NSUserDefaults standardUserDefaults] stringForKey:key])
#define user_defaults_get_array(key)  [[NSUserDefaults standardUserDefaults] arrayForKey:key]
#define user_defaults_get_object(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define user_defaults_set_bool(key, b)   { [[NSUserDefaults standardUserDefaults] setBool:b    forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }
#define user_defaults_set_int(key, i)    { [[NSUserDefaults standardUserDefaults] setInteger:i forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }
#define user_defaults_set_double(key, d) { [[NSUserDefaults standardUserDefaults] setDouble:d  forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }
#define user_defaults_set_string(key, s) { [[NSUserDefaults standardUserDefaults] setObject:s  forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }
#define user_defaults_set_array(key, a)  { [[NSUserDefaults standardUserDefaults] setObject:a  forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }
#define user_defaults_set_object(key, o) { [[NSUserDefaults standardUserDefaults] setObject:o  forKey:key]; [[NSUserDefaults standardUserDefaults] synchronize]; }

#define is_ipad()   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define is_iphone() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define APP_DISPLAY_NAME    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define APP_VERSION     	[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

inline __attribute__((always_inline)) NSString *m_safeString(NSString *str) { return str ? str : @""; }

inline __attribute__((always_inline)) NSString *m_dictionaryValueToString(NSObject *cfObj)
{
    if ([cfObj isKindOfClass:[NSString class]]) return  m_safeString((NSString *)cfObj);
    else return [(NSNumber *)cfObj stringValue];
}

// If we're currently on the main thread, run block() sync, otherwise dispatch block() sync to main thread.
inline __attribute__((always_inline)) void m_executeOnMainThread(void (^block)())
{
    if (block) {
        if ([NSThread isMainThread]) block(); else dispatch_sync(dispatch_get_main_queue(), block);
    }
}



#pragma mark Login TextField Tag enum

typedef enum : NSUInteger {
    Tag_AccountTextField = 100,    //用户名
    Tag_PasswordTextField,         //登录密码
    Tag_EmailTextField,            //邮箱
} YW_LOGIN_TEXTFIELD;

typedef enum : NSUInteger {
    Tag_AccountImageView = 1000,    //用户名
    Tag_PasswordImageView,          //登录密码
    Tag_EmailImageView,             //邮箱
} YW_LOGIN_IMAGEVIEW;

typedef enum : NSUInteger {
    Tag_AccountThumb     = 10000,   //用户名
    Tag_PasswordThumb,              //登录密码
    Tag_EmailThumb,                 //邮箱
} YW_LOGIN_THUMB;

#endif
