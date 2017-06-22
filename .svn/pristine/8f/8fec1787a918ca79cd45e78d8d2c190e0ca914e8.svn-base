//
//  TUserFaceController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserFaceController.h"
#import "TUtilities.h"

#define face_w  180
#define face_h  90

@implementation TUserFaceController

- (id)initWithPosition:(CGPoint)point {
    self = [super init];
    self.position = point;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    float x =  _position.x - face_w/2;
    float y = _position.y - face_h/2;
    [self.view setFrame:CGRectMake(x, y, face_w, face_h)];
    
    // 初始化全局face界面
    _hadLoginFace = [[TUserHadLoginFace alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_hadLoginFace setTargetForButton:self];
    
    _unLoginFace = [[TUnLoginFace alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_unLoginFace setTargetForButton:self];
    
    // 获取是否已经登录
    if([self isAlreadyLogined]) {
        [self.view addSubview:_hadLoginFace];
        TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
        [_hadLoginFace setViewData:dbuyerUser.name andJf:0];
    } else{
        [self.view addSubview:_unLoginFace];
    }
}

- (void)changeViewStatus:(int)integral andIsLogin:(BOOL)isLogin; {
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
        
        if (isLogin) {
            [self.view addSubview:_hadLoginFace];
            TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
            [_hadLoginFace setViewData:dbuyerUser.name andJf:integral];
        } else {
            [self.view addSubview:_unLoginFace];
        }
        
    }
}


- (void)clickLoginButton:(id)sender {
    [self.delegate clickedLogin];
}

- (void)clickJFButton:(id)sender {
    [self.delegate seeIntegral];
}

- (void)dealloc {
    [super dealloc];
    
    [_hadLoginFace release];
    _hadLoginFace = nil;
    
    [_unLoginFace release];
    _unLoginFace = nil;
    
}


@end
