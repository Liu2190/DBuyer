//
//  TAllScoPayView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConfirmPay.h"
#import "TAllScoChoiceView.h"
#import "TAllScoValidataView.h"

@interface TAllScoPayView : UIView {
    // 商户名称
    UILabel *_goodsNameValue;
    
    // 金额
    UILabel *_moneyValue;
    
    // 订单编号
    UILabel *_orderNumValue;
    
    // 交易时间
    UILabel *_tradeTimeValue;
    
    /**
     * 虚拟卡选择控件
     */
    TAllScoChoiceView *_choiceView;
    
    /**
     * 验证码
     */
    TAllScoValidataView *_validataView;
    
    UIButton *_tradeBtn;
}

@property (nonatomic,retain) TConfirmPay *confirmPay;

- (id)initWithFrame:(CGRect)frame andConfirmPay:(TConfirmPay*)confirmPay;
- (void)setTargetForButton:(id)target;

/**
 * 切换虚拟卡选举列表(如果为YES，则是展现;如果为NO，则反之)
 */
- (void)switchAllscoListView:(BOOL)boolValue;

/**
 * 获取控件底部控件坐标
 */
- (CGPoint)getPointForChoiceView;

/**
 * 为虚拟卡选举控件设值
 */
- (void)setValueForChoiceView:(NSString*)value;
- (int)getSelectCardIndexRowValue;
- (void)setSelectCardIndexRowValue:(int)row;

/**
 * 更新block区域
 */
- (void)updateValidataBlock;

/**
 * 获取验证码值
 */
- (NSString*)getValidataNum;

/**
 * 隐藏键盘
 */
- (void)cancelBoard;


@end
