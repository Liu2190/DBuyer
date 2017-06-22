//
//  AddressView.m
//  DBuyer
//
//  Created by lixinda on 13-11-18.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AddressView.h"
#import "BtnDelegate.h"

@implementation AddressView

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
    [_phoneNumber release];
    [_receipt release];
    [_address release];
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // [super setSelected:selected animated:animated];
    [self setSelected:selected animated:animated];
}

- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
