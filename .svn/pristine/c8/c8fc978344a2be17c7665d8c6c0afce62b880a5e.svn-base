//
//  TPasswordController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TPasswordMenuView.h"
#import "TPassScrollView.h"

typedef enum {
    passType_Input_Phone, // 设定默认为手机号输入页
    passType_Input_Verify,
    passType_Reset_Password,
} PasswordPageType;

@interface TPasswordController : TRootViewController<UIScrollViewDelegate,UITextFieldDelegate> {
    TPasswordMenuView *_menuView;
    TPassScrollView *_mainView;
    PasswordPageType _currentDisplayPage; // 当前显示步骤
}

@end
