//
//  TInputVerifyView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TInputVerifyView.h"
#import "TServerFactory.h"
#import "TUserCenterServer.h"
#import "TUtilities.h"

#define margin_left 40
#define margin_top  30

#define textField_h 40

#define valida_btn_w    100

@implementation TInputVerifyView


- (id)initWithFrame:(CGRect)frame andPasswordPageType:(PasswordPageType)passwordPageTyp {
    self = [super initWithFrame:frame andPasswordPageType:passwordPageTyp];
    _isTimer = YES;
    
    float w = (frame.size.width - valida_btn_w - 2*margin_left);
    CGRect textFieldRect = CGRectMake(margin_left, margin_top, w, textField_h);
    self.validaTextField = [[TDbuyerFieldController alloc]initWithPlaceholder:@"输入验证码" andFrame:textFieldRect];
    [_validaTextField getDbuyerTextField].tag = passwordPageTyp;
    [_validaTextField setKeyboardType:UIKeyboardTypePhonePad];
    _validaTextField.getDbuyerTextField.isCenter = YES;
    [_validaTextField setIsValidation:YES];
    [self addSubview:_validaTextField.view];
    
    _getValida = [[UILabel alloc]initWithFrame:CGRectMake(_validaTextField.frame.origin.x+w, margin_top, frame.size.width-w-2*margin_left, textField_h)];
    [_getValida setBackgroundColor:[UIColor colorWithRed:.0/255 green:97.0/255 blue:77.0/255 alpha:1]];
    [_getValida setText:@"获取验证码"];
    _getValida.userInteractionEnabled = YES;
    [_getValida setFont:[UIFont systemFontOfSize:14]];
    [_getValida setTextAlignment:NSTextAlignmentCenter];
    [_getValida setTextColor:[UIColor whiteColor]];
    
    return self;
}

- (void)setTargetAction:(id)target {
    [super setTargetAction:target];
    
    // [[_validaTextField getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSendValida)];
    [_getValida addGestureRecognizer:tap];
    [tap release];
    
    [self addSubview:_getValida];
}


- (NSString *)getTextFieldValue {
    return [_validaTextField getDbuyerTextFieldValue];
}

- (UITextField *)getTextField {
    return [_validaTextField getDbuyerTextField];
}

- (BOOL)updateByTextField:(UITextField *)textField {
    BOOL isValida = [super updateByTextField:textField];
    NSString *textValue = [_validaTextField getDbuyerTextField].text;
    
    if (textValue.length == 0) {
        [_validaTextField changeValidationValue:Input_NO andText:@"验证码不能为空"];
        isValida = NO;
    }else if (![textField.text isEqualToString:self.verifyStr]) {
        [_validaTextField changeValidationValue:Input_NO andText:@"输入的验证码不匹配"];
        isValida = NO;
    }else {
        [_validaTextField changeValidationValue:Input_YES andText:@""];
        isValida = YES;
    }
    
    return isValida;
}

- (void)startTimer {
    [super startTimer];
    _isTimer = NO;
    
    [_getValida setText:@"开始计时(60)"];
    [_getValida setBackgroundColor:[UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1]];
}

- (void)timerAdvanced:(NSTimer*)timer {
    [super timerAdvanced:timer];
    [_getValida setText:[NSString stringWithFormat:@"再次获取(%i)",60-mTime]];
    
    if (mTime == 0) {
        [_getValida setText:@"获取验证码"];
        [_getValida setBackgroundColor:[UIColor colorWithRed:.0/255 green:97.0/255 blue:77.0/255 alpha:1]];
        _isTimer = YES;
    }
}

- (void)doSendValida {
    if(_isTimer) {
        [[TUtilities getInstance]popTarget:self];
        [_validaTextField cancelKeyboard];
        [[TServerFactory getServerInstance:@"TUserCenterServer"]doSendVerifyByUserName:self.phone and:0
                                                                           andCallback:^(NSString *verifyStr) {
                                                                               [[TUtilities getInstance]dismiss];
                                                                               
                                                                               self.verifyStr = verifyStr;
                                                                               [self startTimer];
                                                                           } failureCallback:^(NSString *resp) {
                                                                               [[TUtilities getInstance]popMessageError:resp target:self delayTime:1.0];
                                                                           }];
        
        
    }
}

- (void)dealloc {
    [super dealloc];
    
    [_validaTextField release];
    _validaTextField = nil;
    
    [_getValida release];
    _getValida = nil;
}

@end
