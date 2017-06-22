//
//  TRegisterView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRegisterView.h"

#define textField_size_height   45

@implementation TRegisterView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    mTime = 1;
    _isTimer = NO;

    //
    CGRect phoneRect = CGRectMake(0, 0, frame.size.width, textField_size_height);
    _phoneField = [[TDbuyerFieldController alloc]initWithTextName:@"手机号码"
                                                                          andPlaceholder:@"手机号做您的用户名" andFrame:phoneRect];
    _phoneField.isValidation = YES;
    [_phoneField setKeyboardType:UIKeyboardTypePhonePad];
    [self addSubview:_phoneField.view];
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, _phoneField.view.frame.size.height, _phoneField.view.frame.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [self addSubview:lineView];
    
    CGRect passRect = CGRectMake(0, lineView.frame.origin.y+1, frame.size.width, textField_size_height);
    _passwordField = [[TDbuyerFieldController alloc]initWithTextName:@"设置密码"
                                                                             andPlaceholder:@"设置长度为6-16个字符" andFrame:passRect];
    _passwordField.isValidation = YES;
    [_passwordField setSecureTextEntry:YES];
    [self addSubview:_passwordField.view];
    
    lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, _passwordField.view.frame.origin.y+_passwordField.frame.size.height, _phoneField.view.frame.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [self addSubview:lineView];
    
    CGRect repassRect = CGRectMake(0, lineView.frame.origin.y+1, frame.size.width, textField_size_height);
    _repasswordField = [[TDbuyerFieldController alloc]initWithTextName:@"确认密码"
                                                                             andPlaceholder:@"设置长度为6-16个字符" andFrame:repassRect];
    _repasswordField.isValidation = YES;
    [_repasswordField setSecureTextEntry:YES];
    [self addSubview:_repasswordField.view];
    
    
    //
    CGRect validaRect = CGRectMake(frame.size.width-167, repassRect.origin.y+textField_size_height+10, frame.size.width/2/2, textField_size_height-10);
    _validaField = [[TDbuyerFieldController alloc]initWithPlaceholder:@"输入验证码" andFrame:validaRect];
    [_validaField setPlaceholderFontSize:13];
    [_validaField setKeyboardType:UIKeyboardTypePhonePad];
    [self addSubview:_validaField.view];
    
    _getValidaBtn = [[UILabel alloc]initWithFrame:CGRectMake(validaRect.origin.x+validaRect.size.width, validaRect.origin.y, frame.size.width/2/2+27, validaRect.size.height)];
    [_getValidaBtn setBackgroundColor:[UIColor colorWithRed:.0/255 green:97.0/255 blue:77.0/255 alpha:1]];
    [_getValidaBtn setText:@"获取验证码"];
    _getValidaBtn.userInteractionEnabled = YES;
    [_getValidaBtn setFont:[UIFont systemFontOfSize:14]];
    [_getValidaBtn setTextAlignment:NSTextAlignmentCenter];
    [_getValidaBtn setTextColor:[UIColor whiteColor]];
    [self addSubview:_getValidaBtn];
    
    //
    _agreementButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _agreementButton.frame=CGRectMake(frame.size.width-167, _getValidaBtn.frame.origin.y+_getValidaBtn.frame.size.height+10, 15, 15);
    [_agreementButton setBackgroundImage:[UIImage imageNamed:@"Image_select_no.png"] forState:UIControlStateNormal];
    [_agreementButton setBackgroundImage:[UIImage imageNamed:@"Image_select_yes.png"] forState:UIControlStateSelected];
    [self addSubview:_agreementButton];
    
    UILabel *agreeLabel = [[[UILabel alloc]init]autorelease];
    [agreeLabel setFont:[UIFont systemFontOfSize:12]];
    [agreeLabel setText:@"我已阅读并同意"];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [agreeLabel.text sizeWithFont:agreeLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [agreeLabel setFrame:CGRectMake(_agreementButton.frame.origin.x+_agreementButton.frame.size.width+5, _agreementButton.frame.origin.y, titleSize.width, titleSize.height)];
    [agreeLabel setBackgroundColor:[UIColor clearColor]];
    [agreeLabel setTextColor:[UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1]];
    [self addSubview:agreeLabel];
    
    _protocolLabel = [[UILabel alloc]initWithFrame:CGRectMake(agreeLabel.frame.origin.x+agreeLabel.frame.size.width, agreeLabel.frame.origin.y, 80, 15)];
    [_protocolLabel setFont:[UIFont systemFontOfSize:12]];
    [_protocolLabel setText:@"《注册协议》"];
    [_protocolLabel setBackgroundColor:[UIColor clearColor]];
    [_protocolLabel setTextColor:[UIColor colorWithRed:62.0/255.0 green:142.0/255.0 blue:105.0/255.0 alpha:1]];
    _protocolLabel.userInteractionEnabled = YES;
    [self addSubview:_protocolLabel];

    return self;
}

- (void)cancelKeyboard {
    [_phoneField cancelKeyboard];
    [_passwordField cancelKeyboard];
    [_repasswordField cancelKeyboard];
    [_validaField cancelKeyboard];
}

- (void)setTargetAction:(id)target {
    [_phoneField setTextFieldDelegate:target];
    [_passwordField setTextFieldDelegate:target];
    [_repasswordField setTextFieldDelegate:target];
    
    [[_phoneField getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_passwordField getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_repasswordField getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // [_getValidaBtn addTarget:target action:@selector(theValidaBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:target action:@selector(theValidaBtnClicked:)];
    [_getValidaBtn addGestureRecognizer:tap];
    [tap release];
    
    [_agreementButton addTarget:target action:@selector(agreementBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    tap=[[UITapGestureRecognizer alloc]initWithTarget:target action:@selector(protocolSelected)];
    [_protocolLabel addGestureRecognizer:tap];
    [tap release];
}

- (BOOL)updateByTextField:(UITextField*)textField {
    BOOL isValida = YES;
    id phoneTextField = [_phoneField getDbuyerTextField];
    if (phoneTextField == textField) { // 手机号
        if (textField.text.length == 0) {
            [_phoneField changeValidationValue:Input_NO andText:@"帐号不能为空"];
            isValida = NO;
        } else if(textField.text.length > 11 || textField.text.length < 11) {
            [_phoneField changeValidationValue:Input_NO andText:@"输入的手机号长度不符"];
            isValida = NO;
        } else if (textField.text.length == 11 && [textField.text isMatchedByRegex:PhoneRegex]==NO) {
            [_phoneField changeValidationValue:Input_NO andText:@"输入的手机号格式不符"];
            isValida = NO;
        } else if([textField.text isMatchedByRegex:PhoneRegex]==YES){
            [_phoneField changeValidationValue:Input_YES andText:@"输入的手机号格式不符"];
        } else {
            [_phoneField changeValidationValue:Input_YES andText:@""];
            isValida = YES;
        }
    }
    
    id passwordTextField = [_passwordField getDbuyerTextField];
    if (passwordTextField == textField) { // 密码
        if (textField.text.length == 0) {
            [_passwordField changeValidationValue:Input_NO andText:@"密码不能为空"];
            isValida = NO;
        } else if(textField.text.length < 6){
            [_passwordField changeValidationValue:Input_NO andText:@"输入的密码不能小于6位"];
            isValida = NO;
        } else {
            [_passwordField changeValidationValue:Input_YES andText:@""];
            isValida = YES;
        }
    }
    
    id repasswordTextField = [_repasswordField getDbuyerTextField];
    if (repasswordTextField == textField) { // 确认密码
        
        if (textField.text.length == 0) {
            [_repasswordField changeValidationValue:Input_NO andText:@"密码不能为空"];
            isValida = NO;
        } else if(textField.text.length < 6){
            [_repasswordField changeValidationValue:Input_NO andText:@"输入的密码不能小于6位"];
            isValida = NO;
        } else if (textField.text.length>=6 && ![textField.text isEqualToString:[_passwordField getDbuyerTextField].text]) {
            [_repasswordField changeValidationValue:Input_NO andText:@"两次密码输入不正确"];
            isValida = NO;
        } else {
            [_repasswordField changeValidationValue:Input_YES andText:@""];
            isValida = YES;
        }
    }
    
    return isValida;
}

- (void)changeAgreementButtonImage {
     [_agreementButton setSelected:!_agreementButton.isSelected];
}

- (UITextField*)getPhoneToTextField {
    return [_phoneField getDbuyerTextField];
}

- (UITextField*)getPasswordToTextField {
    return [_passwordField getDbuyerTextField];
}

- (UITextField*)getRePasswordToTextField {
    return [_repasswordField getDbuyerTextField];
}

- (NSString*)getVerifyCode {
    return [_validaField getDbuyerTextFieldValue];
}

- (BOOL)getAgreementBoolValue {
    return _agreementButton.isSelected;
}

- (void)startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
    [_getValidaBtn setBackgroundColor:[UIColor colorWithRed:141.0/255 green:141.0/255 blue:141.0/255 alpha:1]];
    _isTimer = NO;
    [_getValidaBtn setText:@"开始计时(60)"];
}

- (void)timerAdvanced:(NSTimer*)timer {
    mTime++;
    if(mTime >= 60) {
        mTime = 0;
        [timer invalidate];
    } else {
        
    }
    
    
    [_getValidaBtn setText:[NSString stringWithFormat:@"再次获取(%i)",60-mTime]];
    
    if (mTime == 0) {
        [_getValidaBtn setText:@"获取验证码"];
        [_getValidaBtn setBackgroundColor:[UIColor colorWithRed:.0/255 green:97.0/255 blue:77.0/255 alpha:1]];
        _isTimer = YES;
    }
}


- (void)dealloc {
    [super dealloc];
    
    [_phoneField release];
    _phoneField = nil;
    
    [_repasswordField release];
    _repasswordField = nil;
    
    [_passwordField release];
    _passwordField = nil;
    
    [_validaField release];
    _validaField = nil;
    
    [_agreementButton release];
    _agreementButton = nil;
    
    [_protocolLabel release];
    _protocolLabel = nil;
}

@end
