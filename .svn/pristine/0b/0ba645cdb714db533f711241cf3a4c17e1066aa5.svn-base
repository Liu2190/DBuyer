//
//  SelectSuperMarketSection.m
//  DBuyer
//
//  Created by simman on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SelectSuperMarketSection.h"

@interface SelectSuperMarketSection(){
    id _target;
    SEL _action;
}

@end

@implementation SelectSuperMarketSection

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
    [_DistrictLable release];
    [_DistrictButton release];
    [super dealloc];
}
- (void)addTarget:(id)target Action:(SEL)action
{
    _target = target;
    _action = action;
}
- (IBAction)DistrictButtonAction:(id)sender {
    [_target performSelector:_action withObject:sender];
}
@end
