//
//  PlanServer.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanServer.h"
#import "DBManager.h"

@implementation PlanServer
-(void)doGetPlanLsitBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:planList,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *postDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(NSString *key in [postDict allKeys])
    {
        [item setPostValue:[postDict objectForKey:key] forKey:key];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetPlanListRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)doDeleteAPlanBy:(PlanModal *)plan callback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:updatePlan,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:plan.planid forKey:@"id"];
    [item setPostValue:@"-1" forKey:@"status"];
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoDeleteAPlanRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [super requestFinished:request];
    NSDictionary *requestDictionary = [request userInfo];
    NSDictionary *packData = [[NSDictionary alloc]initWithDictionary:[requestDictionary objectForKey:@"packedData"]] ;
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetPlanListRequest)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        [[DBManager sharedDatabase] getListFromNetWithDict:packData WithUsername:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];//将计划写入数据库中
        ((void(^)(NSDictionary*))callback)(packData);
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoDeleteAPlanRequest)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
}
@end
