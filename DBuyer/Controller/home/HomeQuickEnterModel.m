//
//  HomeQuickEnterModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HomeQuickEnterModel.h"

@implementation HomeQuickEnterModel
-(id)init
{
    self = [super init];
    if(self)
    {
        self.dataSourceURL = [[NSString alloc]init];
        self.iconURL = [[NSString alloc]init];
        self.thisID = [[NSString alloc]init];
        self.name = [[NSString alloc]init];
        self.type = [[NSString alloc]init];
    }
    return self;
}
-(id)initHomeQuickEnterModelWith:(NSMutableDictionary *)dict
{
    if(![self init])
    {
        [self init];
    }
    self.dataSourceURL = [self isEmptyOfString:[dict objectForKey:@"dataSourceURL"]] == NO?[dict objectForKey:@"dataSourceURL"]:@"";
    self.iconURL =[self isEmptyOfString:[dict objectForKey:@"iconURL"]]==NO ? [dict objectForKey:@"iconURL"]:@"";
    self.thisID = [self isEmptyOfString:[dict objectForKey:@"id"]]==NO?[dict objectForKey:@"id"]:@"";
    self.name = [self isEmptyOfString:[dict objectForKey:@"name"]]==NO?[dict objectForKey:@"name"]:@"";
    self.type = [self isEmptyOfString:[dict objectForKey:@"type"]]==NO?[NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]]:@"";
    return self;
}
-(BOOL)isEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return NO;
    }
    return YES;
}
@end
