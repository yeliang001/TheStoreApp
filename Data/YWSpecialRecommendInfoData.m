//
//  SpecialRecommendInfo.m
//  TheStoreApp
//
//  Created by YaoWang on 14-5-13.
//  Copyright (c) 2014年 YiYaoWang. All rights reserved.
//

#import "YWSpecialRecommendInfoData.h"

@implementation YWSpecialRecommendInfoData

@synthesize spaceCode;
@synthesize content;
@synthesize pic;
@synthesize title;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:spaceCode forKey:@"spaceCode"];
    [aCoder encodeObject:content forKey:@"content"];
    [aCoder encodeObject:pic forKey:@"pic"];
    [aCoder encodeObject:title forKey:@"title"];
    
    [aCoder encodeInt:_triggerType forKey:@"triggerType"];
    [aCoder encodeInt:_platId forKey:@"platId"];
    [aCoder encodeInt:_specialId forKey:@"specialId"];
    [aCoder encodeInt:_areaId forKey:@"areaId"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.spaceCode = [aDecoder decodeObjectForKey:@"spaceCode"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    self.pic = [aDecoder decodeObjectForKey:@"pic"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    
    self.triggerType = [[aDecoder decodeObjectForKey:@"triggerType"] intValue];
    self.specialId = [[aDecoder decodeObjectForKey:@"specialId"] intValue];
    self.platId = [[aDecoder decodeObjectForKey:@"platId"] intValue];
    self.areaId = [[aDecoder decodeObjectForKey:@"areaId"] intValue];

    return self;
}

- (NSString *)description
{
    NSString *desc = [NSString stringWithFormat:@"\nspaceCode %@\ncontent %@\npic %@\ntitle %@\ntriggerType %d\nspecialId %d\nplatId %d\nareaId %d",spaceCode,content,pic,title,_triggerType,_platId,_specialId,_areaId];
    return desc;
}
@end
