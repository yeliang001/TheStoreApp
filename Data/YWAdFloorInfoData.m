//
//  AdFloorInfo.m
//  TheStoreApp
//
//  Created by LinPan on 13-7-29.
//
//

#import "YWAdFloorInfoData.h"

@implementation YWAdFloorInfoData

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_head forKey:@"head"];
    [aCoder encodeObject:_bigPage forKey:@"bigPage"];
    [aCoder encodeObject:_productList forKey:@"productList"];
    [aCoder encodeObject:_keywordList forKey:@"keywordList"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.head = [aDecoder decodeObjectForKey:@"head"];
    self.bigPage = [aDecoder decodeObjectForKey:@"bigPage"];
    self.productList = [aDecoder decodeObjectForKey:@"productList"];
    self.keywordList = [aDecoder decodeObjectForKey:@"keywordList"];
    return  self;
}

@end
