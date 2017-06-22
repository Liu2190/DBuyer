//
//  AppDelegateServer.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"

@interface AppDelegateServer : TBaseServer
/**
 *获取版本更新网络请求
 **/
-(void)doVersionUpdateBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
@end
