//
//  Login.m
//  DBuyer
//
//  Created by liuxiaodan on 13-9-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "Login.h"
#import "BtnDelegate.h"
@implementation Login

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

- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
