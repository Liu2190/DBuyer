//
//  TLocalKitHandler.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

typedef enum {
    operation_verNo, // default
    operation_insert,
    operation_select,
    operation_deleate
}OperationType;

typedef enum {
    view_home
}ViewType;

#import <Foundation/Foundation.h>

@interface TLocalKitHandler : NSObject {
    ViewType *_viewType;
    OperationType *_operationType;
    
    
}

+ (id)getInstance;

/**
 * 集成本地操作
 */
- (id)doActionWithOperationType:(OperationType)operationType;

/**
 * 获取远程数据
 */
- (void)doRemoteServer:(int)verNo
           andCallback:(void(^)(id data))callback
       failureCallback:(void(^)(NSString *resp))failureCallback;

@end
