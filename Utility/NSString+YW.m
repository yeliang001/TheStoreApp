//
//  NSString+YW.m
//  TheStoreApp
//
//  Created by xingyong on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "NSString+YW.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (YW)
+ (NSString *)stringWithNowDate
{
    NSDate *nowDate = [NSDate date];
    NSString *formatter = @"yyyy-MM-dd";
    
    return [NSString stringWithDate:nowDate formater:formatter];
    
}

+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater
{
    if (!date) {
        return  nil;
    }
    if (!formater) {
        formater = @"yyyy-MM-dd";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formater];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringWithSize:(float)fileSize
{
    NSString *sizeStr;
    if(fileSize/1024.0/1024.0/1024.0 > 1)
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fGB",fileSize/1024.0/1024.0/1024.0];
    }
    else if(fileSize/1024.0/1024.0 > 1 && fileSize/1024.0/1024.0 < 1024 )
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fMB",fileSize/1024.0/1024.0];
    }
    else
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fKB",fileSize/1024.0];
    }
    
    
    return sizeStr;
    
}


- (NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

- (BOOL) isEmail{
	
    NSString *emailRegEx =
	@"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
	@"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
	@"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
	@"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
	@"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
	@"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
	@"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}
@end
