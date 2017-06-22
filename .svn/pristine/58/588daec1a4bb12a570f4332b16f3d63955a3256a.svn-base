//
//  TRowModel.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRowModel.h"

@implementation TRowModel

- (id)init {
    self = [super init];
    _isArrow = YES;
    _isClicked = YES;
    _isSperator = NO;
    
    self.datas = [[NSMutableDictionary alloc]init];
    
    return self;
}

- (void)addDataValue:(id)value andKey:(NSString *)key {
    [_datas setObject:value forKey:key];
}

- (void)dealloc {
    [super dealloc];
    [_datas release];
    _datas = nil;
}

@end
