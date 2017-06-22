//
//  TAllScoValidataView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDbuyerFieldController.h"

/**
 * 验证码输入控件
 */
@interface TAllScoValidataView : UIView {
    UILabel *_getValidataBtn;
    TDbuyerFieldController *_validataFieldCon;
    
    BOOL _isTimer;
    int mTime;
}

- (void)setTargetForView:(id)target;

/**
 * 更新验证码按钮区域包括背景颜色和文字以及计算器来更新文字数的递减
 */
- (void)updateValidataBlock;

/**
 * 获取验证码
 */
- (NSString*)getValidataNum;

- (void)cancelBoard;

@end
