//
//  TUserFaceController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TUserHadLoginFace.h"
#import "TUnLoginFace.h"
#import "TUserCenterDelegate.h"


@interface TUserFaceController : UIViewController {
    TUserHadLoginFace *_hadLoginFace;
    TUnLoginFace *_unLoginFace;
}

@property (nonatomic,assign) CGPoint position;
@property (nonatomic,assign) id<TUserCenterDelegate> delegate;

- (id)initWithPosition:(CGPoint)point;

/**
 *  更新登录UI界面
 */
- (void)changeViewStatus:(int)integral andIsLogin:(BOOL)isLogin;

@end
