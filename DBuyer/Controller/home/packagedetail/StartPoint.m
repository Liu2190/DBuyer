//
//  StartPoint.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "StartPoint.h"

@implementation StartPoint
+(float)startPoint{
    float startPoint;
    if([[[UIDevice currentDevice]systemVersion]compare:@"7.0"]==NSOrderedAscending)
    {
        startPoint=44.0f;
    }
    else
    {
        startPoint=64.0f;
    }

    return startPoint;
}
@end
