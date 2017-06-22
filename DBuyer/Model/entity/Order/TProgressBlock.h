//
//  TProgressBlock.h
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TProgressBlock : TRecord

@property (nonatomic,retain) NSString *createDate;
@property (nonatomic,assign) int execute;
@property (nonatomic,retain) NSString *orderId;
@property (nonatomic,assign) int status;

@end
