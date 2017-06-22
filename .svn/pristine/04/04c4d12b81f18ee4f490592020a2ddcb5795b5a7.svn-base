//
//  TConfirmPayWayView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PayWay_UM,      // 设定默认为银联
    PayWay_KQ,      // 快钱支付
    PAyWay_ALLSCO,  // 奥斯卡支付
    
} PayWayType;

/**
 * 支付方式选举列表
 */
@interface TConfirmPayWayView : UIView


@property (nonatomic,retain) NSMutableArray *payways;

- (id)initWithFrame:(CGRect)frame andPayways:(NSArray*)payways;

/**
 * 获取界面高度
 */
- (CGFloat)heightForView;

/**
 * 获取用户选择的支付方式
 */
- (int)getPayWay2checkBox;


@end
