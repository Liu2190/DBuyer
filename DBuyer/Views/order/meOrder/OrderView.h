//
//  OrderView.h
//  DBuyer
//
//  Created by lixinda on 13-11-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIView


#pragma mark - 方法
- (IBAction)ButtonAction:(id)sender;                            // 按钮点击事件
- (void)addTarget:(id)target Action:(SEL)select;                // TARGET_ACTION

+ (OrderView *)loadNibViewWithName:(NSString *)nibName;


#pragma mark - 属性
@property (retain, nonatomic) IBOutlet UILabel *stayPaymentTip; // 待付款订单
@property (retain, nonatomic) IBOutlet UILabel *consigneTip;    // 待收货订单
@property (retain, nonatomic) IBOutlet UILabel *FinishTip;      // 已完成订单
@property (retain, nonatomic) IBOutlet UIImageView *stayPaymentBubble;
@property (retain, nonatomic) IBOutlet UIImageView *consigneBubble;
@property (retain, nonatomic) IBOutlet UIImageView *finishBubble;
@property (retain, nonatomic) IBOutlet UILabel *tuikuanTip;
@property (retain, nonatomic) IBOutlet UIImageView *tuikuanBubble;



- (void)setStayPayment:(BOOL)isHidden tipNum:(NSInteger)num;
- (void)setConsigne:(BOOL)isHidden tipNum:(NSInteger)num;
- (void)setFinish:(BOOL)isHidden tipNum:(NSInteger)num;
- (void)setTuikuan:(BOOL)isHidden tipNum:(NSInteger)num;
@end
