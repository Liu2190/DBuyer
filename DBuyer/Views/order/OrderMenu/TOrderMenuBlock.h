//
//  TOrderMenuBlock.h
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOrderMenuDelegate.h"

@interface TOrderMenuBlock : UIView {
    UIButton *_menuButton;
    
    UIImageView *_remindNumImageView;
    UILabel *_remindNumLabel;
}

@property (nonatomic,assign) id<TOrderMenuDelegate> delegate;


- (id)initWithFrame:(CGRect)frame andDelegate:(id)delObj;
- (void)setOrderMenuViewData:(NSString *)imageName;
- (void) showMarkNumber:(int)number;

/**
 为订单按钮设置tag标志,在事件传递中会用到
 */
- (void)setFlagForMenuBtn:(int)flag;
- (int)getFlagForMenuBtn;

@end
