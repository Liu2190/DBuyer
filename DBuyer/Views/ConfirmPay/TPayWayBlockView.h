//
//  TPayWayBlockView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPayWayBlockView : UIView {
    UIButton *_selectPayBtn;
}

- (id)initWithFrame:(CGRect)frame logoImageName:(NSString*)logoImageName andLogoDescName:(NSString*)logoDescName;

/**
 * 设置目标行为
 */
- (void)setActionForTarget:(id)target;

/**
 * 设置按钮tag值
 */
- (void)setTagForBtn:(int)paywayType;

/**
 * 获取按钮tag值
 */
- (int)getTagForBtn;


/**
 * 检查按钮是否被选择
 */
- (BOOL)isSelected2Btn;

/**
 * 更改按钮图片通过是否选择
 */
- (void)updateBtnImage:(BOOL)isSelected;

@end
