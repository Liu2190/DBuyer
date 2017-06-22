//
//  OrderView.m
//  DBuyer
//
//  Created by lixinda on 13-11-17.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//
#import "OrderView.h"

@interface OrderView()
@property (nonatomic, assign) id viewController;    // 控制器
@property (nonatomic) SEL select;                   // 要执行的方法
@end

@implementation OrderView

+ (id)loadNibViewWithName:(NSString *)nibName
{
    if (nibName) {
        // 设置NavigationBar
        return [[[NSBundle mainBundle] loadNibNamed:@"OrderView" owner:nil options:nil] lastObject];
    }
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark - TARGET_ACTION
- (void)addTarget:(id)target Action:(SEL)select
{
    self.viewController = target;
    self.select = select;
}

#pragma mark 按钮点击事件
- (IBAction)ButtonAction:(id)sender
{
    
    [self.viewController performSelector:_select withObject:sender];
}

#pragma mark - 设置待付款Bubble
- (void)setStayPayment:(BOOL)isHidden tipNum:(NSInteger)num
{
    self.stayPaymentTip.hidden = isHidden;
    self.stayPaymentBubble.hidden = isHidden;
    if (!isHidden) {
        self.stayPaymentTip.text = [NSString stringWithFormat:@"%d", num];
    }
}
#pragma mark - 设置待收货Bubble
- (void)setConsigne:(BOOL)isHidden tipNum:(NSInteger)num
{
    self.consigneTip.hidden = isHidden;
    self.consigneBubble.hidden = isHidden;
    if (!isHidden) {
        self.consigneTip.text = [NSString stringWithFormat:@"%d", num];
    }
}
#pragma mark - 设置已完成Bubble
- (void)setFinish:(BOOL)isHidden tipNum:(NSInteger)num
{
    self.FinishTip.hidden = isHidden;
    self.finishBubble.hidden = isHidden;
    if (!isHidden) {
        self.FinishTip.text = [NSString stringWithFormat:@"%d", num];
    }
}
#pragma mark - 设置退款订单
- (void)setTuikuan:(BOOL)isHidden tipNum:(NSInteger)num
{
    self.tuikuanBubble.hidden = isHidden;
    self.tuikuanTip.hidden = isHidden;
    if (!isHidden) {
        self.tuikuanTip.text = [NSString stringWithFormat:@"%d", num];
    }
}
- (void)dealloc {
    [_stayPaymentBubble release];
    [_consigneBubble release];
    [_finishBubble release];
    [_tuikuanTip release];
    [_tuikuanBubble release];
    [super dealloc];
}
@end
