//
//  TBasePassView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBasePassView.h"
#import "TUtilities.h"

#define next_btn_w    110
#define next_btn_h    30


@implementation TBasePassView

- (id)initWithFrame:(CGRect)frame andPasswordPageType:(PasswordPageType)passwordPageTyp {
    self = [super initWithFrame:frame];
    mTime = 0;
    
    [self addActionBtn:passwordPageTyp];
    
    return self;
}

- (void) addActionBtn:(PasswordPageType)passwordPageTyp {
    CGRect nextRect = CGRectMake((self.frame.size.width-next_btn_w)/2, 100, next_btn_w, next_btn_h);
    _nextBtn = [[UIButton alloc]initWithFrame:nextRect];
    _nextBtn.tag = passwordPageTyp;
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"password_next.png"] forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"password_next_clicked.png"] forState:UIControlStateHighlighted];
    
    [self addSubview:_nextBtn];
}

- (void)setTargetAction:(id)target {
    [_nextBtn addTarget:target action:@selector(doNextPage:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSString*)getTextFieldValue {
    return @"";
}

- (UITextField*)getTextField{
    return nil;
}

- (BOOL)updateByTextField:(UITextField*)textField {
    return YES;
}

- (void)startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
}

- (void)timerAdvanced:(NSTimer*)timer {
    mTime++;
    if(mTime >= 60) {
        mTime = 0;
        [timer invalidate];
    } else {
        
    }
}

@end
