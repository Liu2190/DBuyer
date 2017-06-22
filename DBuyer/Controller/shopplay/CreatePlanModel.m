//
//  CreatePlanModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CreatePlanModel.h"

@implementation CreatePlanModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _planNameString = [[NSString alloc]init];
        _planImageId = [[NSString alloc]init];
        _planIconNormal = [[NSString alloc]init];
        _planIconHigh = [[NSString alloc]init];
    }
    return self;
}
@end
