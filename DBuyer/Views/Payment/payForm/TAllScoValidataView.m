//
//  TAllScoValidataView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoValidataView.h"

#define btn_validata_length     110

#define getValidata_Font_Size   16

@implementation TAllScoValidataView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = 2.0;
    self.layer.masksToBounds = YES;
    _isTimer = YES;
    mTime = 1;

    _getValidataBtn = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-btn_validata_length-.3, .5, btn_validata_length, frame.size.height-1)];
    [_getValidataBtn setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:125.0/255.0 blue:192.0/255.0 alpha:1.0]];
    _getValidataBtn.layer.cornerRadius = 1.5;
    _getValidataBtn.layer.masksToBounds = YES;
    _getValidataBtn.userInteractionEnabled = YES;
    [_getValidataBtn setFont:[UIFont systemFontOfSize:getValidata_Font_Size]];
    [_getValidataBtn setTextColor:[UIColor whiteColor]];
    [_getValidataBtn setText:@"获取验证码"];
    _getValidataBtn.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_getValidataBtn];
    
    CGRect rect = CGRectMake(5, 5, frame.size.width-btn_validata_length-.3-5, frame.size.height-2*5);
    _validataFieldCon = [[TDbuyerFieldController alloc]initWithPlaceholder:@"输入手机验证码" andFrame:rect];
    [_validataFieldCon setKeyboardType:UIKeyboardTypePhonePad];
    [self addSubview:_validataFieldCon.view];
    
    return self;
}

- (void)setTargetForView:(id)target {
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:target action:@selector(theValidaBtnClicked:)];
    tap.numberOfTapsRequired = 1;
    [_getValidataBtn addGestureRecognizer:tap];
    [tap release];
}

- (void)updateValidataBlock {
    if (!_isTimer) return;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    [_getValidataBtn setBackgroundColor:[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1.0]];
    [_getValidataBtn setText:@"重新获取(60)"];
    _isTimer = NO;
}

- (void)timerAdvanced:(NSTimer*)timer {
    mTime++;
    if(mTime >= 60) {
        mTime = 0;
        [timer invalidate];
    } else {
        
    }
    
    
    [_getValidataBtn setText:[NSString stringWithFormat:@"重新获取(%i)",60-mTime]];
    
    if (mTime == 0) {
        [_getValidataBtn setText:@"获取验证码"];
        [_getValidataBtn setBackgroundColor:[UIColor colorWithRed:.0/255 green:97.0/255 blue:77.0/255 alpha:1]];
        _isTimer = YES;
    }
}

- (NSString*)getValidataNum {
    return [_validataFieldCon getDbuyerTextFieldValue];
}

- (void)cancelBoard {
    [_validataFieldCon cancelKeyboard];
}

- (void)dealloc {
    [super dealloc];
    
    [_getValidataBtn release];
    _getValidataBtn = nil;
    
    [_validataFieldCon release];
    _validataFieldCon = nil;
}

@end
