//
//  TSectionModel.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TSectionModel.h"

@implementation TSectionModel

- (id)init {
    self = [super init];
    self.rows = [[NSMutableArray alloc]init];
    
    return self;
}

- (void)addRowModel:(TRowModel*)rowModel {
    [_rows addObject:rowModel];
}

- (void)dealloc {
    [super dealloc];
    
    [_rows release];
    _rows = nil;
}

@end
