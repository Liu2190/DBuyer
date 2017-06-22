//
//  TInputPhoneView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TInputPhoneView.h"

#define phoneTextField_margin_left   40
#define phoneTextField_margin_top    30

#define phoneTextField_size_h        45

@implementation TInputPhoneView

- (id)initWithFrame:(CGRect)frame andPasswordPageType:(PasswordPageType)passwordPageTyp {
    self = [super initWithFrame:frame andPasswordPageType:passwordPageTyp];
    
    CGRect textFieldRect = CGRectMake(phoneTextField_margin_left, phoneTextField_margin_top, frame.size.width-2*phoneTextField_margin_left, phoneTextField_size_h);
    _textFieldController = [[TDbuyerFieldController alloc]initWithTextName:@"帐号"
                                                                                   andPlaceholder:@"输入您注册时的手机号" andFrame:textFieldRect];
    [_textFieldController setIsValidation:YES];
    [_textFieldController setKeyboardType:UIKeyboardTypePhonePad];
    [_textFieldController getDbuyerTextField].tag = passwordPageTyp;
    
    [self addSubview:_textFieldController.view];
    
    return self;
}

- (void)setTargetAction:(id)target {
    [super setTargetAction:target];
    [_textFieldController setTextFieldDelegate:target];
    
    [[_textFieldController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)updateByTextField:(UITextField *)textField {
    BOOL isValida = YES;
    
    if (textField.text.length == 0) {
        [_textFieldController changeValidationValue:Input_NO andText:@"帐号不能为空"];
        isValida = NO;
    } else if(textField.text.length > 11 || textField.text.length < 11) {
        [_textFieldController changeValidationValue:Input_NO andText:@"输入的手机号长度不符"];
        isValida = NO;
    } else if (textField.text.length == 11 && [textField.text isMatchedByRegex:PhoneRegex]==NO) {
        [_textFieldController changeValidationValue:Input_NO andText:@"输入的手机号格式不符"];
        isValida = NO;
    } else if([textField.text isMatchedByRegex:PhoneRegex]==YES){
        [_textFieldController changeValidationValue:Input_YES andText:@"输入的手机号格式不符"];
    } else {
        [_textFieldController changeValidationValue:Input_Default andText:@""];
        isValida = NO;
    }
    
    return isValida;
}



- (NSString*)getTextFieldValue {
    return [_textFieldController getDbuyerTextFieldValue];
}

- (UITextField*)getTextField {
    return [_textFieldController getDbuyerTextField];
}

- (void)cancellKeyboard {
    [_textFieldController cancelKeyboard];
}



- (void)dealloc {
    [super dealloc];
    
    [_textFieldController release];
    _textFieldController = nil;
}

@end
