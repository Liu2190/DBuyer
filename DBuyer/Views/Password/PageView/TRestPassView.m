//
//  TRestPassView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRestPassView.h"

#define next_btn_w    110
#define next_btn_h    30

#define margin_left 30
#define margin_top  20

#define textField_h 45


@implementation TRestPassView

- (id)initWithFrame:(CGRect)frame andPasswordPageType:(PasswordPageType)passwordPageTyp {
    self = [super initWithFrame:frame andPasswordPageType:passwordPageTyp];
    
    CGRect passRect = CGRectMake(margin_left, margin_top, frame.size.width-2*margin_left, textField_h);
    _passwordController = [[TDbuyerFieldController alloc]initWithPlaceholder:@"新密码" andFrame:passRect];
    [_passwordController setIsValidation:YES];
    [_passwordController setSecureTextEntry:YES];
    [_passwordController getDbuyerTextField].tag = passwordPageTyp;
    [self addSubview:_passwordController.view];
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(margin_left, margin_top+textField_h, passRect.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [self addSubview:lineView];
    
    CGRect repassRect =  CGRectMake(margin_left, margin_top+textField_h+1, frame.size.width-2*margin_left, textField_h);
    _rePasswordController = [[TDbuyerFieldController alloc]initWithPlaceholder:@"验证密码" andFrame:repassRect];
    [_rePasswordController setIsValidation:YES];
    [_rePasswordController setSecureTextEntry:YES];
    [_rePasswordController getDbuyerTextField].tag = passwordPageTyp;
    [self addSubview:_rePasswordController.view];
    
    return self;    
}

- (void)setTargetAction:(id)target {
    [super setTargetAction:target];
    [[_passwordController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_rePasswordController getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)addActionBtn:(PasswordPageType)passwordPageTyp {
    CGRect nextRect = CGRectMake((self.frame.size.width-next_btn_w)/2, 2*textField_h+2*margin_top, next_btn_w, next_btn_h);
    
    _nextBtn = [[UIButton alloc]initWithFrame:nextRect];
    _nextBtn.tag = passwordPageTyp;
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"password_finish_clicked"] forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"password_finish.png"] forState:UIControlStateHighlighted];
    
    [self addSubview:_nextBtn];
}

- (BOOL)updateByTextField:(UITextField *)textField {
    BOOL isValida = YES;
    UITextField *passwordTextField = [_passwordController getDbuyerTextField];
    // 密码
    if (textField == passwordTextField) {
        if (textField.text.length == 0) {
            [_passwordController changeValidationValue:Input_NO andText:@"密码不能为空"];
            isValida = NO;
        } else if (textField.text.length < 6) {
            [_passwordController changeValidationValue:Input_NO andText:@"密码长度不能小于6位"];
            isValida = NO;
        } else {
            [_passwordController changeValidationValue:Input_YES andText:@""];
            isValida = YES;
        }
    }
    
    
    // 确认密码
    UITextField *repasswordTextField = [_rePasswordController getDbuyerTextField];
    
    if (textField == repasswordTextField) {
        if (textField.text.length == 0) {
            [_rePasswordController changeValidationValue:Input_NO andText:@"确认密码不能为空"];
            isValida = NO;
        } else if (textField.text.length < 6) {
            [_rePasswordController changeValidationValue:Input_NO andText:@"确认密码长度不能小于6位"];
            isValida = NO;
        } else if (![textField.text isEqualToString:passwordTextField.text]) {
            [_rePasswordController changeValidationValue:Input_NO andText:@"两次输入密码不正确"];
            isValida = NO;
        } else {
            [_rePasswordController changeValidationValue:Input_YES andText:@"两次输入密码不正确"];
            isValida = YES;
        }
    }

    return isValida;
}

- (UITextField *)getPasswordTextField {
    return [_passwordController getDbuyerTextField];
}

- (UITextField *)getRePasswordTextField {
    return [_rePasswordController getDbuyerTextField];
}

- (void)cancelKeyboard {
    [_passwordController cancelKeyboard];
    [_rePasswordController cancelKeyboard];
}


@end
