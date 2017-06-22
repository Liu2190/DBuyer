

//
//  keyBoardView.m
//  DBuyer
//
//  Created by simman on 14-1-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "keyBoardView.h"

@interface keyBoardView() {
    id _target;
    SEL _faction;
    SEL _caction;
}


@end

@implementation keyBoardView

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

- (id)initWithNib
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"keyBoardView" owner:self options:nil] lastObject];
    return self;
}

- (void)addTarget:(id)target finishAction:(SEL)faction cancelAction:(SEL)caction
{
    _target = target;
    _caction = caction;
    _faction = faction;
}

- (IBAction)finishButtonAction:(id)sender {
    if (_target && _faction) {
        [_target performSelector:_faction withObject:self];
    }
}

- (IBAction)cancelButtonAction:(id)sender {
    if (_target && _caction) {
        [_target performSelector:_caction withObject:self];
    }
}
+(float)keyBoardViewHeight
{
    return 30.0f;
}
@end
