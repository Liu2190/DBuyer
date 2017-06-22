//
//  TLoginView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TLoginView.h"
#import "TDbuyerFieldController.h"

#import "TServerFactory.h"
#import "TUserCenterServer.h"

#import "TUtilities.h"


#define forget_view_height  40
#define action_view_height  60
#define forget_label_height 30

#define mobile_placeholder      @"手机号/用户名"
#define password_placeholder    @"输入密码"

@implementation TLoginView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UIView *accountView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-(forget_label_height+action_view_height))]autorelease];
    [self addSubview:accountView];
    
    //
    CGRect accountRect = CGRectMake(0, 0, accountView.frame.size.width, accountView.frame.size.height/2-0.5);
    _accountControl = [[TDbuyerFieldController alloc]initWithImageName:@"login_user_image" andPlaceholder:mobile_placeholder andFrame:accountRect];
    [_accountControl setKeyboardType:UIKeyboardTypePhonePad];
    [_accountControl setFont:[UIFont systemFontOfSize:16]];
    [_accountControl setIsValidation:YES];
    [accountView addSubview:_accountControl.view];
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, accountView.frame.size.height/2-0.5, accountView.frame.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [accountView addSubview:lineView];
    
    CGRect passwordRect = CGRectMake(0, lineView.frame.origin.y+1, accountView.frame.size.width, accountView.frame.size.height/2-0.5);
    _passwordControl = [[TDbuyerFieldController alloc]initWithImageName:@"login_pdw_image" andPlaceholder:password_placeholder andFrame:passwordRect];
    _passwordControl.secureTextEntry = YES;
    [_passwordControl setIsValidation:YES];
    [accountView addSubview:_passwordControl.view];
    
    //
    UIView *actionView = [[[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-forget_label_height-action_view_height, frame.size.width, action_view_height)]autorelease];
    [self addSubview:actionView];
    
    CGRect registerRect = CGRectMake(0, 15, (actionView.frame.size.width-40)/2, actionView.frame.size.height-30);
    _registerBtn = [[UIButton alloc]initWithFrame:registerRect];
    [_registerBtn setImage:[UIImage imageNamed:@"Login_doRegi_default.png"] forState:UIControlStateNormal];
    [_registerBtn setImage:[UIImage imageNamed:@"Login_doRegi_clicked.png"] forState:UIControlStateSelected];
    [actionView addSubview:_registerBtn];
    
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(actionView.frame.size.width/2+20, 15, (actionView.frame.size.width-40)/2, actionView.frame.size.height-30)];
    [_loginBtn setImage:[UIImage imageNamed:@"Login_doLogin_default.png"] forState:UIControlStateNormal];
    [_loginBtn setImage:[UIImage imageNamed:@"Login_doLogin_clicked.png"] forState:UIControlStateSelected];
    [actionView addSubview:_loginBtn];
    
    
    //
    _forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height-forget_label_height-5, 60, 15)];
    [_forgetBtn setImage:[UIImage imageNamed:@"Login_forget_default.png"] forState:UIControlStateNormal];
    [_forgetBtn setImage:[UIImage imageNamed:@"Login_forget_clicked.png"] forState:UIControlStateSelected];
    [self addSubview:_forgetBtn];
    
    return self;
}

- (void)setTargetAction:(id)target {
    [_accountControl setTextFieldDelegate:target];
    [_passwordControl setTextFieldDelegate:target];
    
    [[_accountControl getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [[_passwordControl getDbuyerTextField] addTarget:target action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_registerBtn addTarget:target action:@selector(registerBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn addTarget:target action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_forgetBtn addTarget:target action:@selector(forgetBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)updateByTextField:(UITextField*)field {
    BOOL isValida = YES;
    
    if([field.placeholder isEqualToString:mobile_placeholder]) {
        if (field.text.length == 0) {
            [_accountControl changeValidationValue:Input_NO andText:@"帐号不能为空"];
            isValida = NO;
        } else if(field.text.length < 11) {
            [_accountControl changeValidationValue:Input_NO andText:@"输入的手机号长度不符"];
            isValida = NO;
        } else if(field.text.length > 11) {
             [_accountControl changeValidationValue:Input_NO andText:@"输入的手机号长度不符"];
            isValida = NO;
        } else if (field.text.length == 11 && [field.text isMatchedByRegex:PhoneRegex]==NO) {
            [_accountControl changeValidationValue:Input_NO andText:@"输入的手机号格式不符"];
            isValida = NO;
        } else if([field.text isMatchedByRegex:PhoneRegex]==YES){
            [_accountControl changeValidationValue:Input_YES andText:@"输入的手机号格式不符"];
        } else {
            [_accountControl changeValidationValue:Input_Default andText:@""];
            isValida = NO;
        }
    }
    
    if([field.placeholder isEqualToString:password_placeholder]) {
        if (field.text.length == 0) {
            [_passwordControl changeValidationValue:Input_NO andText:@"密码不能为空"];
            isValida = NO;
        } else if(field.text.length < 6){
            [_passwordControl changeValidationValue:Input_NO andText:@"输入的密码不能小于6位"];
            isValida = NO;
        } else {
            [_passwordControl changeValidationValue:Input_YES andText:@""];
            isValida = YES;
        }
    }
    
    return isValida;
}


- (NSString*)getUserName {
    return [_accountControl getDbuyerTextFieldValue];
}

- (NSString*)getPassword {
    return [_passwordControl getDbuyerTextFieldValue];
}

- (void)cancelKeyboard {
    [_accountControl cancelKeyboard];
    [_passwordControl cancelKeyboard];
}

- (void) setPhoneAccount {
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [_accountControl getDbuyerTextField].text = dbuyerUser.name;
}

- (void)cleanTextFieldValue {
    [_accountControl getDbuyerTextField].text =@"";
    [_passwordControl getDbuyerTextField].text = @"";
}


- (void)dealloc {
    [super dealloc];
    
    [_accountControl release];
    _accountControl = nil;
    
    [_passwordControl release];
    _passwordControl = nil;
    
    [_registerBtn release];
    _registerBtn = nil;
    
    [_loginBtn release];
    _loginBtn = nil;
    
    [_forgetBtn release];
    _forgetBtn = nil;
}


@end
