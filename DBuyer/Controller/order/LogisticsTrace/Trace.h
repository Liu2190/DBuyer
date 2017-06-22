//
//  Trace.h
//  DBuyer
//
//  Created by simman on 14-1-17.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Trace : NSObject
@property (nonatomic, assign) NSString *status;      // 状态码
@property (nonatomic, retain) NSString *status_name; // 状态名
@property (nonatomic, assign) NSInteger createDate;  // 创建时间
@property (nonatomic, assign) NSInteger execute;     // 是否已经执行
@property (nonatomic, retain) NSString *orderId;     // 商品ID
@property (nonatomic, assign) NSInteger traceType;   // 类别（物流：0，自提1）

/**
 *  根据Dic生成Trace对象
 *
 *  @param dic 网络返回的Trace字典
 *
 *  @return self
 */
- (id)initWithDic:(NSMutableDictionary *)dic;


@end
