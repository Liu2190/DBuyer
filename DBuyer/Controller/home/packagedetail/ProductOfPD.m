//
//  ProductOfPD.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProductOfPD.h"

@implementation ProductOfPD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_bottomImage release];
    [_productName release];
    [_productImage release];
    [_sellPrice release];
    [_marketPrice release];
    [_markImage release];
    [super dealloc];
}
@end
