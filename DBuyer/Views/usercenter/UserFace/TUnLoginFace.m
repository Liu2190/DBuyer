//
//  TUnLoginFace.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUnLoginFace.h"

#define loginBtn_w  100
#define loginBtn_h  25
@implementation TUnLoginFace

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    UILabel *wellComeLabel = [[[UILabel alloc]init]autorelease];
    wellComeLabel.text = @"Hi! 欢迎来到BHG~";
    [wellComeLabel setBackgroundColor:[UIColor clearColor]];
    [wellComeLabel setTextColor:[UIColor whiteColor]];
    wellComeLabel.font = [UIFont systemFontOfSize:14];
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [wellComeLabel.text sizeWithFont:wellComeLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [wellComeLabel setFrame:CGRectMake((frame.size.width-titleSize.width)/2, 40, titleSize.width, titleSize.height)];
    [self addSubview:wellComeLabel];
    
    
    _loginButton = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-loginBtn_w)/2, frame.size.height-loginBtn_h, 100, 20)];
    [_loginButton setImage:[UIImage imageNamed:@"UserCenter_LoginBtn.png"] forState:UIControlStateNormal];
    [self addSubview:_loginButton];
    
    return self;
}

- (void)setTargetForButton:(id)target {
    [_loginButton addTarget:target action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
}


@end
