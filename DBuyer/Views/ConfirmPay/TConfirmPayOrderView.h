//
//  TConfirmPayOrderView.h
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TConfirmPay.h"

/**
 * 订单信息视图
 */
@interface TConfirmPayOrderView : UIView {
    TConfirmPay *_confirmPay;
}


- (id)initWithFrame:(CGRect)frame andConfirmPay:(TConfirmPay*)confirmPay;
- (CGFloat)heightForView;


@end
