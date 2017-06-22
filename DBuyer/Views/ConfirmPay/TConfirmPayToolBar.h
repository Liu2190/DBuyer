//
//  TConfirmPayToolBar.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Action工具栏视图区域
 */
@interface TConfirmPayToolBar : UIView {
    UIButton *_payActionBtn;
}

@property (nonatomic,retain) NSString *payAmount;

- (id)initWithFrame:(CGRect)frame andPayAmount:(NSString*)payAmount;

- (void)setActionForTarget:(id)target;

@end
