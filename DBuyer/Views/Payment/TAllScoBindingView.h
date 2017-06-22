//
//  TAllScoBindingView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDbuyerFieldController.h"
#import "TAllScoBindingForm.h"

@interface TAllScoBindingView : UIView {
    TDbuyerFieldController *_phoneFieldController;
    TDbuyerFieldController *_cartFieldController;
    TDbuyerFieldController *_validaFieldController;
    
    UIButton *_button;
}

/**
 * 取消键盘
 */
- (void)cancelKeyboard;

/**
 * 设置目标行为
 */
- (void)setTargetForAction:(id)target;

/**
 * 表单提交验证,如有验证不通过则提示
 */
- (BOOL)validataFormAction;

/**
 * 验证表单控件，如验证有误则弹出提示信息
 */
- (BOOL)validataTextFieldAction:(UITextField*)textField;

/**
 * 获取绑定商银信实体表单数据
 */
- (TAllScoBindingForm*)getAllscoBindingEnity;

@end
