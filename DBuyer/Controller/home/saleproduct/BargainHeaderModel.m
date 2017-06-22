//
//  BargainHeaderModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BargainHeaderModel.h"

@implementation BargainHeaderModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _activPicUrl = [[NSString alloc]init];
        _activInterfaceUrl = [[NSString alloc]init];
        _activFlag = NO;
        _aoskPicUrl = [[NSString alloc]init];
        _aoskInterfaceUrl = [[NSString alloc]init];
        _aoskFlag = NO;
        _isActivHasData = NO;
        _isAoskHasData = NO;
        _activShareText = [[NSString alloc]init];
        _activJumptype = [[NSString alloc]init];
        _aoskJumptype = [[NSString alloc]init];
    }
    return self;
}
-(void)setBargainHeaderModelWith:(NSMutableDictionary *)dict
{
    if([self whetherArrayNeeded:[dict objectForKey:@"activityintro"]])
    {
        if([[dict objectForKey:@"activityintro"] count]!=0)
        {
            self.isActivHasData = YES;
            for(NSDictionary *dict1 in [dict objectForKey:@"activityintro"])
            {
                if([[dict1 objectForKey:@"pic_url"] length]==0||[[dict1 objectForKey:@"pic_url"]isKindOfClass:[NSNull class]]||[dict1 objectForKey:@"pic_url"]==nil||[dict1 objectForKey:@"pic_url"] ==NULL)
                {
                    self.isActivHasData = NO;
                }
                self.activPicUrl =[self notEmptyOfString:[dict1 objectForKey:@"pic_url"]]?[dict1 objectForKey:@"pic_url"]:@"";
                self.activInterfaceUrl = [self notEmptyOfString:[dict1 objectForKey:@"interface_url"]]?[dict1 objectForKey:@"interface_url"]:@"";
                if([self notEmptyOfString:[dict1 objectForKey:@"flag"]])
                {
                    self.activFlag = ([[dict1 objectForKey:@"flag"] intValue]==0)?NO:YES;
                }
                self.activShareText = [self notEmptyOfString:[dict1 objectForKey:@"sharetext"]]?[dict1 objectForKey:@"sharetext"]:@"";
                self.activJumptype = [self notEmptyOfString:[dict1 objectForKey:@"jumptype"]]?[dict1 objectForKey:@"jumptype"]:@"";
            }
        }
    }
    else
    {
        self.isActivHasData = NO;
    }
    if([self whetherArrayNeeded:[dict objectForKey:@"ask"]])
    {
        if([[dict objectForKey:@"ask"] count]!=0)
        {
            self.isAoskHasData = YES;
            for(NSDictionary *dict1 in [dict objectForKey:@"ask"])
            {
                if([[dict1 objectForKey:@"pic_url"] length]==0||[[dict1 objectForKey:@"pic_url"]isKindOfClass:[NSNull class]]||[dict1 objectForKey:@"pic_url"]==nil||[dict1 objectForKey:@"pic_url"] ==NULL)
                {
                    self.isAoskHasData = NO;
                }
                self.aoskPicUrl = [self notEmptyOfString:[dict1 objectForKey:@"pic_url"]]?[dict1 objectForKey:@"pic_url"]:@"";
                self.aoskInterfaceUrl = [self notEmptyOfString:[dict1 objectForKey:@"interface_url"]]?[dict1 objectForKey:@"interface_url"]:@"";
                if([self notEmptyOfString:[dict1 objectForKey:@"flag"]])
                {
                    self.aoskFlag = ([[dict1 objectForKey:@"flag"] intValue]==0)?NO:YES;
                }
                self.aoskJumptype = [self notEmptyOfString:[dict1 objectForKey:@"jumptype"]]?[dict1 objectForKey:@"jumptype"]:@"";
            }
        }
    }
    else
    {
        self.isAoskHasData = NO;
    }
}
-(BOOL)notEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
-(BOOL)whetherDictNeeded:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        if([item isKindOfClass:[NSDictionary class]])
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)whetherArrayNeeded:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        if([item isKindOfClass:[NSArray class]])
        {
            return YES;
        }
    }
    return NO;
}
@end
