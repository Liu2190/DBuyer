//
//  SettlementFooterView.h
//  DBuyer
//
//  Created by simman on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  结算中心底部积分视图
 */
@interface SettlementFooterView : UIView

@property (retain, nonatomic) IBOutlet UILabel *integralLable;              // 可用积分
@property (retain, nonatomic) IBOutlet UILabel *priceLable;                 // 等于多少钱
@property (retain, nonatomic) IBOutlet UITextField *useIntegralTextField;   // 使用积分


// 初始化
- (id)initWithNib;
- (IBAction)useIntegralAction:(id)sender;                       // 使用Button事件

/**
 *  按钮回调事件
 *
 *  @param target       控制器
 *  @param action       方法
 *  @param finishAction 键盘Finish事件
 *  @param cancelAction 键盘Cancel事件
 */
- (void)addTarget:(id)target Action:(SEL)action KeyBoardFinshAction:(SEL)finishAction KeyBoardCancelAction:(SEL)cancelAction;

@end
