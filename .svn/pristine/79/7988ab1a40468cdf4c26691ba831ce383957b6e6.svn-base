//
//  TAllScoBindingView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoBindingView.h"
#import "TUtilities.h"

#define margin_left 0
#define margin_top  0
#define textField_h 45

@implementation TAllScoBindingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    CGRect textFieldRect = CGRectMake(margin_left, 0, self.frame.size.width, textField_h);
    _phoneFieldController = [[TDbuyerFieldController alloc]initWithTextName:@"手机号" andPlaceholder:@"输入手机号" andFrame:textFieldRect];
    [_phoneFieldController setKeyboardType:UIKeyboardTypePhonePad];
    [_phoneFieldController setDbuyerTextValue:dbuyerUser.name];
    _phoneFieldController.isEdit = NO;
    [_phoneFieldController setIsValidation:YES];

    [self addSubview:_phoneFieldController.view];
    
    float y = _phoneFieldController.view.frame.size.height+_phoneFieldController.frame.origin.y;
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.frame.size.width, .5)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:.5]];
    [self addSubview:lineView];
    
    CGRect cartRect = CGRectMake(0, lineView.frame.size.height+lineView.frame.origin.y, self.frame.size.width, textField_h);
    _cartFieldController = [[TDbuyerFieldController alloc]initWithTextName:@"卡   号" andPlaceholder:@"填写您的储值卡卡号" andFrame:cartRect];
    [_cartFieldController setKeyboardType:UIKeyboardTypePhonePad];
    [_cartFieldController setIsValidation:YES];
    [self addSubview:_cartFieldController.view];
    
    y = _cartFieldController.view.frame.size.height+_cartFieldController.frame.origin.y;
    lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.frame.size.width, .5)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:.5]];
    [self addSubview:lineView];
    
    CGRect validataRect = CGRectMake(0, lineView.frame.size.height+lineView.frame.origin.y, self.frame.size.width, textField_h);
    _validaFieldController = [[TDbuyerFieldController alloc]initWithTextName:@"验证码" andPlaceholder:@"您购卡时获取的验证码" andFrame:validataRect];
    [_validaFieldController setIsValidation:YES];
    [_validaFieldController setKeyboardType:UIKeyboardTypePhonePad];
    [self addSubview:_validaFieldController.view];
    
    y = _validaFieldController.view.frame.size.height+_validaFieldController.frame.origin.y;
    lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.frame.size.width, .5)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:.5]];
    [self addSubview:lineView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button  setFrame:CGRectMake(0, lineView.frame.size.height+lineView.frame.origin.y+20, frame.size.width, textField_h-5)];
    [_button setImage:[UIImage imageNamed:@"AllScoBinding_Binding.png"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"AllScoBinding_Binding_Clicked.png"] forState:UIControlStateHighlighted];
    [self addSubview:_button];
    
    return self;
}

- (void)cancelKeyboard {
    [_cartFieldController cancelKeyboard];
    [_validaFieldController cancelKeyboard];
}

- (void)setTargetForAction:(id)target {
    [_phoneFieldController setTextFieldDelegate:target];
    [_cartFieldController setTextFieldDelegate:target];
    [_validaFieldController setTextFieldDelegate:target];
    
    [_button addTarget:target action:@selector(doBindingCards:) forControlEvents:UIControlEventTouchUpInside];
    
    [[_phoneFieldController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_cartFieldController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_validaFieldController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)validataFormAction {
    BOOL booleValue = YES;
    
    if (booleValue)
    booleValue = [self validataTextFieldAction:_cartFieldController.getDbuyerTextField];
    
    if (booleValue)
    booleValue = [self validataTextFieldAction:_validaFieldController.getDbuyerTextField];
    
    return booleValue;
}

- (BOOL)validataTextFieldAction:(UITextField*)textField {
    BOOL booleValue = YES;
    
    if (textField == _cartFieldController.getDbuyerTextField) { // 验证商银卡卡号输入格式
        if (textField.text.length == 0) {
            [_cartFieldController changeValidationValue:Input_NO andText:@"卡号不能为空"];
            booleValue = NO;
        } else if(textField.text.length > 19 || textField.text.length < 19) {
            [_cartFieldController changeValidationValue:Input_NO andText:@"输入的卡号长度不符"];
            booleValue = NO;
        } else {
            [_cartFieldController changeValidationValue:Input_YES andText:@""];
            booleValue = YES;
        }
    }
    
    if (textField == _validaFieldController.getDbuyerTextField) { // 验证输入验证码是否与下发的相同
        if (textField.text.length == 0) {
            [_validaFieldController changeValidationValue:Input_NO andText:@"验证码不能为空"];
            booleValue = NO;
        } else {
            booleValue = YES;
        }
    }
    
    return booleValue;
}

- (TAllScoBindingForm*)getAllscoBindingEnity {
    TAllScoBindingForm *allScoForm = [[TAllScoBindingForm alloc]init];
    allScoForm.phoneNumber = _phoneFieldController.getDbuyerTextField.text;
    allScoForm.cardNumber = _cartFieldController.getDbuyerTextField.text;
    allScoForm.validaNumber = _validaFieldController.getDbuyerTextField.text;
    
    return allScoForm;
}


@end
