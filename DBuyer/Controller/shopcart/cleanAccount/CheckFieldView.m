//
//  CheckFieldView.m
//  DBuyer
//
//  Created by lixinda on 13-11-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "CheckFieldView.h"
#import "BtnDelegate.h"

@implementation CheckFieldView

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



- (IBAction)didClickBtnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
