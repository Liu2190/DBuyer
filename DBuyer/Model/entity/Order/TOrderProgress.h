//
//  TOrderProgress.h
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TOrderProgress : TRecord

@property (nonatomic,retain) NSString *J;
@property (nonatomic,retain) NSString *Z;
@property (nonatomic,retain) NSString *jinfo;
@property (nonatomic,assign) int logss;
@property (nonatomic,retain) NSMutableArray *progress;

@end
