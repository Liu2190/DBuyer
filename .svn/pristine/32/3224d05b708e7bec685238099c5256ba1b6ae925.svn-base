//
//  DbuyerActive.m
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "DbuyerActive.h"

static DbuyerActive *instance = nil;

@implementation DbuyerActive

+ (id)getInstance {
    @synchronized(self)	{ // 避免多线程并发创建多个实例
		if (instance == nil) {
            instance = [[DbuyerActive alloc]init];
        }
	}
    
    return instance;
}


@end
