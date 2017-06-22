//
//  TAllscoOrderDelegate.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    direction_up,
    direction_down,
    direction_bottom,
    direction_top,
    direction_up_none,
    direction_down_none
}ScrollDirection;

@protocol TAllscoOrderDelegate <NSObject>

- (void)pushBuyerDetail:(id)detailObj;
- (void)pushChargeDetail:(id)detailObj;

- (void)scrollHidenTabBarByDistance:(float)distance andDirection:(ScrollDirection)direction;

@end
