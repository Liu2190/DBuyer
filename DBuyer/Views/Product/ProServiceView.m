//
//  ProServiceView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProServiceView.h"

@implementation ProServiceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    self.arrowImage.autoresizesSubviews = NO;
    self.arrowImage.autoresizingMask = UIViewAutoresizingNone;
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
    [_arrowImage release];
    [_serviceLabel release];
    [_serviceButton release];
    [_sepImage release];
    [super dealloc];
}
@end
