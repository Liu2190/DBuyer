//
//  GiftSever.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "GiftSever.h"
#import "GiftCell.h"
@implementation GiftSever

-(void)doGetPackageListBycallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:DaBox,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetPackageListRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}
-(void)doGetPackageDetailById:(NSString *)gid callback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:findboxStructureById,serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    for(int i = 0;i<[[dict allKeys] count];i++)
    {
        [item setPostValue:[[dict allValues] objectAtIndex:i] forKey:[[dict allKeys] objectAtIndex:i]];
    }
    [item setPostValue:gid forKey:@"boxID"];
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetPackageDetailsRequest],USER_INFO_KEY_TYPE, nil]];
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
    if([[packData objectForKey:@"status"]intValue]!=0)
    {
        NSString *error = [packData objectForKey:@"msg"];
        id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
        ((void(^)(NSString *))failureCallback)(error);
        return;
    }
    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetPackageListRequest)
    {
        NSArray *arr = [packData objectForKey:@"gift_list"];
        NSMutableArray *packages = [NSMutableArray array];
        for(int i=0;i<[arr count];i++){
            
            NSDictionary *giftDic=[arr objectAtIndex:i];
            GiftCell *giftCell = [[GiftCell alloc]init];
            giftCell.boxPicUrl = [giftDic objectForKey:@"boxPicUrl"];
            giftCell.title = [giftDic objectForKey:@"title"];
            giftCell.tpye = [[giftDic objectForKey:@"type"] integerValue];
            giftCell.price = [[giftDic objectForKey:@"price"] floatValue];
            giftCell.savePrice = [[giftDic objectForKey:@"savePrice"] floatValue];
            giftCell.gid = [giftDic objectForKey:@"gid"];
            giftCell.nameList = [giftDic objectForKey:@"nameList"];
            giftCell.boxDescription=[giftDic objectForKey:@"boxComments"];
            [packages addObject:giftCell];
        }
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray*))callback)(packages);
    }

    if([[requestDictionary objectForKey:USER_INFO_KEY_TYPE] floatValue] == DoGetPackageDetailsRequest)
    {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSDictionary*))callback)(packData);
    }
}
@end