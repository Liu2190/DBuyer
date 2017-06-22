//
//  TStoreMapServer.h
//  DBuyer
//
//  Created by dilei liu on 14-4-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"

@interface TStoreMapServer : TBaseServer

- (void)doGetAddress2Map:(void(^)(NSArray *resp))callback failureCallback:(void(^)(NSString *resp))failureCallback;

@end
