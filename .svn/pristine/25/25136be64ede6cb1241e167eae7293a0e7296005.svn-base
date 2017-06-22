//
//  PaymentAlertView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentAlertViewDelegate <NSObject>

// index = 0; -> 返回首页
// index = 1; -> 查看详情

- (void)paymentAlertViewDidClickedButton:(NSInteger)index;

@end


@interface PaymentAlertView : UIView

@property (nonatomic, assign) id <PaymentAlertViewDelegate> delegate;

// 便利构造器方法
+ (id)paymentAlertView;

- (IBAction)backHomeButtonClicked:(UIButton *)sender;
- (IBAction)showOrderButtonClicked:(UIButton *)sender;

@end
