//
//  BuyViewOfPD.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BuyViewOfPD.h"
#import "BtnDelegate.h"
@implementation BuyViewOfPD

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
    [_buyButton release];
    [super dealloc];
}
- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
