//
//  TBaseServer.h
//  Tutebang
//
//  Created by dilei liu on 12-12-24.
//  Copyright (c) 2012年 柳 刚强. All rights reserved.
//

#import "TBaseLocal.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "RequestDelegate.h"

#define kCompleteCallback @"completeCallback"
#define kFailureCallback @"failureCallback"


@interface TBaseServer : TBaseLocal

#define TTB_VERSION                 @"1"
#define TTB_IOS_CLIENTTYPE          @"1"

#define USER_INFO_KEY_TYPE          @"requestType"

@property (retain) id<RequestDelegate> calldel;

@property (nonatomic,retain) ASINetworkQueue *requestQueue;
@property (nonatomic,copy) NSString *authCode;
@property (nonatomic,copy) NSString *authToken;
@property (nonatomic,copy) NSString *userId;


- (BOOL)isRunning;
- (void)start;
- (void)pause;
- (void)resume;
- (void)cancel;

- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;

- (void)setGetUserInfo:(ASIHTTPRequest *)request withRequestType:(RequestType)requestType;
- (void)setPostUserInfo:(ASIFormDataRequest *)request withRequestType:(RequestType)requestType;
- (void)setUserInfo:(NSDictionary*)requestInfo;
- (NSURL*)generateURL:(NSString*)baseURL params:(NSDictionary*)params;

@end
