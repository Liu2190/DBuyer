//
//  PlanServer.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-19.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseServer.h"
#import "PlanModal.h"
@interface PlanServer : TBaseServer
/**
 *查询购物计划列表接口
 **/
-(void)doGetPlanLsitBycallback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;
/**
 *删除某一条购物计划
 **/
-(void)doDeleteAPlanBy:(PlanModal *)plan callback:(void (^)(NSDictionary *))callback failureCallback:(void (^)(NSString *))failureCallback;

@end
