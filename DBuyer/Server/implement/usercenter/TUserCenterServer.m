//
//  TUserCenterServer.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterServer.h"
#import "TOrder.h"


@implementation TUserCenterServer

- (void)doGetAbountDataByCallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/userHelpView/queryAfter?type=4", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoGetAbountDataRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doExitLoginByCallback:(void (^)(NSString *))callback failureCallback:(void (^)(NSString *))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/interface/user/out", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];

    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoExitLoginRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void) doLoginByUserName:(NSString*)username andPassword:(NSString*)password andCallback:(void(^)(TDbuyerUser *dbuyerUser))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/user/login", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:username forKey:@"phone"];
    [item setPostValue:password forKey:@"password"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:[MD5 md5] forKey:@"verify"];
    [item setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"] forKey:@"versionNum"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d", [UIDevice currentResolution]] forKey:@"size_code"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoLoginRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doSendVerifyByUserName:(NSString*)username and:(int)reqflag
                   andCallback:(void(^)(NSString *verifyStr))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    
    NSString *uri = @"interface/user/regGetValidCode";
    if (reqflag==0) uri = @"interface/user/forgetGetValidCode";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serviceHost,uri]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:username forKey:@"mobile"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:[MD5 md5] forKey:@"verify"];
    [item setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"] forKey:@"versionNum"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d", [UIDevice currentResolution]] forKey:@"size_code"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoVerifyRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)doRegisterDbuyerByUserName:(NSString*)userName andpassword:(NSString*)password andCode:(NSString*)code
                       andCallback:(void(^)(NSString *verifyStr))callback failureCallback:(void(^)(NSString *resp))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/user/register", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];
    [item setPostValue:userName forKey:@"phone"];
    [item setPostValue:password forKey:@"password"];
    [item setPostValue:code forKey:@"validCode"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:[MD5 md5] forKey:@"verify"];
    [item setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"] forKey:@"versionNum"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d", [UIDevice currentResolution]] forKey:@"size_code"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoRegisterRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)updatePasswordByUserName:(NSString *)userName andpassword:(NSString *)password andCode:(NSString *)code
                     andCallback:(void (^)(NSString *))callback failureCallback:(void (^)(NSString *))failureCallback {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@interface/user/updateUserPassword", serviceHost]];
    ASIFormDataRequest *item = [[ASIFormDataRequest alloc] initWithURL:url];

    [item setPostValue:userName forKey:@"phone"];
    [item setPostValue:password forKey:@"password"];
    [item setPostValue:code forKey:@"IdentifyingCode"];
    [item setPostValue:[TimeStamp timeStamp] forKey:@"stamp"];
    [item setPostValue:[MD5 md5] forKey:@"verify"];
    [item setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"] forKey:@"versionNum"];
    [item setPostValue:@"2" forKey:@"os_code"];
    [item setPostValue:[NSString stringWithFormat:@"%d", [UIDevice currentResolution]] forKey:@"size_code"];
    
    NSArray *objects = @[[[callback copy] autorelease], [[failureCallback copy] autorelease]];
    NSArray *keys = @[kCompleteCallback, kFailureCallback];
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    [requestInfo addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:DoUpdatePasswordRequest],USER_INFO_KEY_TYPE, nil]];
    [item setUserInfo:requestInfo];
    [self.requestQueue addOperation:item];
    [self start];
    [item release];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    [super requestFinished:request];
    NSDictionary *requestDictionary = [request userInfo];
    NSDictionary *packData = [requestDictionary objectForKey:@"packedData"];

    if ([[packData objectForKey:@"status"]intValue] != 0) {
        NSString *error = [packData objectForKey:@"msg"];
        id failureCallback  = [requestDictionary objectForKey:kFailureCallback];
        ((void(^)(NSString *))failureCallback)(error);
        
        return;
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoGetAbountDataRequest) {
        NSDictionary *dict  = [requestDictionary objectForKey:@"packedData"];
        NSArray *array = [dict objectForKey:@"list"];
        NSDictionary *dic = [array objectAtIndex:0];
        NSString *addressStrings = [dic objectForKey:@"content"];
        NSArray *datas = [addressStrings componentsSeparatedByString:@"dbuyer@"];
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSArray *))callback)(datas);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoExitLoginRequest) {
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        NSString *msg = [dict objectForKey:@"msg"];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString *))callback)(msg);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoLoginRequest) {
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        NSDictionary *userDict = [dict objectForKey:@"user"];
        TDbuyerUser *dbuyerUser = [[TDbuyerUser alloc]initWithJsonDictionary:userDict];
        
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(TDbuyerUser*))callback)(dbuyerUser);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoVerifyRequest) {
        NSDictionary *dict = [requestDictionary objectForKey:@"packedData"];
        NSString *code = [dict objectForKey:@"ValidCode"];
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(code);
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoRegisterRequest) {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(@"");
    }
    
    if ([[requestDictionary objectForKey:USER_INFO_KEY_TYPE]floatValue] == DoUpdatePasswordRequest) {
        id callback  = [requestDictionary objectForKey:kCompleteCallback];
        ((void(^)(NSString*))callback)(@"");
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [super requestFailed:request];
}

- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL {
    [super request:request willRedirectToURL:newURL];
    
}


@end
