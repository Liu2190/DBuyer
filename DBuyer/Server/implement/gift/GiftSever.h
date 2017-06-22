//
//  GiftSever.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"

@interface GiftSever : TBaseServer
-(void)doGetPackageListBycallback:(void (^)(NSArray *))callback failureCallback:(void (^)(NSString *))failureCallback;
-(void)doGetPackageDetailById:(NSString *)gid callback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
@end
