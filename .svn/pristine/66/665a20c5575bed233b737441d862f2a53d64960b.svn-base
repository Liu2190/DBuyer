//
//  HomeBannerModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HomeBannerModel.h"

@implementation HomeBannerModel
-(id)init
{
    self= [super init];
    if(self)
    {
        self.imgURL = [[NSString alloc]init];
        self.pageID = [[NSString alloc]init];
        self.pageURL = [[NSString alloc]init];
        self.resultID = [[NSString alloc]init];
        self.sharetext = [[NSString alloc]init];
    }
    return self;
}
-(id)initDataWithDict:(NSMutableDictionary *)dict
{
    if(![self init])
    {
        [self init];
    }
    self.imgURL = [self notEmptyOfString:[dict objectForKey:@"imgURL"]]?[dict objectForKey:@"imgURL"]:@"";
    self.pageID = [self notEmptyOfString:[dict objectForKey:@"pageID"]]?[dict objectForKey:@"pageID"]:@"";
    self.pageURL = [self notEmptyOfString:[dict objectForKey:@"pageURL"]]?[dict objectForKey:@"pageURL"]:@"";
    self.resultID = [self notEmptyOfString:[dict objectForKey:@"resultID"]]?[dict objectForKey:@"resultID"]:@"";
    self.sharetext = [self notEmptyOfString:[dict objectForKey:@"sharetext"]]?[dict objectForKey:@"sharetext"]:@"";
    return self;
}
-(BOOL)notEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
@end
