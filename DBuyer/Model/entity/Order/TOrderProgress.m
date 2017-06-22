//
//  TOrderProgress.m
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderProgress.h"
#import "TProgressBlock.h"

@implementation TOrderProgress

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.J = [dic objectForKey:@"J"];
    self.Z = [dic objectForKey:@"Z"];
    self.jinfo = [dic objectForKey:@"jinfo"];
    self.logss = [[dic objectForKey:@"logss"]intValue];
    
    NSArray *zinfos = [dic objectForKey:@"zinfo"];
    self.progress = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in zinfos) {
        TProgressBlock *progressBlock = [[TProgressBlock alloc]initWithJsonDictionary:dict];
        [_progress addObject:progressBlock];
        [progressBlock release];
    }
}

@end
