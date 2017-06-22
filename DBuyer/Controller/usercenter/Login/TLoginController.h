//
//  TLoginController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRootViewController.h"
#import "TLoginHandlerDelegate.h"
#import "TRegisterHandlerDelegate.h"
#import "TLoginView.h"

@interface TLoginController : TRootViewController<UITextFieldDelegate,UIScrollViewDelegate,TRegisterHandlerDelegate> {
    TLoginView *_loginView;
}

@property (nonatomic,assign) id<TLoginHandlerDelegate> delegate;

@end
