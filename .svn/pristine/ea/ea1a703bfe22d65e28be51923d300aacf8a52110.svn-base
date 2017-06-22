//
//  WaitBuyerPayOrderCell.m
//  DBuyer
//
//  Created by simman on 14-1-4.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "WaitBuyerPayOrderCell.h"
#import "TimeStamp.h"
#import "Product.h"
#import "Order.h"
@interface WaitBuyerPayOrderCell() {
    id _viewController;    // 控制器
    SEL _payAction;           // 要执行的方法
    SEL _cbAction;
    SEL _cAction;   // 取消
    BOOL _checkBoxStatus;    // 复选框状态
    long long _orderDate;   // 订单创建时间
    NSTimer *_timer;        // 计时器
}
@end

@implementation WaitBuyerPayOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _checkBoxStatus = NO;
        _timeOut = NO;
        _timer = nil;
        // Initialization code
    }
    return self;
}

#pragma mark - 初始化
- (IBAction)orderCancelAction:(id)sender {
    [_viewController performSelector:_cAction withObject:self];
}

- (IBAction)goPayButtonAction:(id)sender {
    [_viewController performSelector:_payAction withObject:_indexPath];
}

- (WaitBuyerPayOrderCell *)initWithNib
{
    WaitBuyerPayOrderCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WaitBuyerPayOrderCell" owner:nil options:nil] lastObject];
    return cell;
}


#pragma mark - 设置cell的值
- (void)setCellValue:(Order *)order
{
    self.order = order;
    self.orderNumber.text = order.orderId;
    // 提取第一个Product
    Product *product = [order.productList objectAtIndex:0];
    [self.goodsImage setImageWithURL:[NSURL URLWithString: product.attrValue]];//[UIImage imageNamed:product.attrValue];
    self.goodsTitle.text = product.commodityName;
    /*
     NSArray * goodsList = [orderDic objectForKey:@"goodsList"];
     self.giftPrice = [orderDic objectForKey:@"amountPayable"];
     self.orderType = [orderDic objectForKey:@"buyType"];
     self.paidAmount = [[orderDic objectForKey:@"paidAmount"] floatValue];
     self.destorTime = [[orderDic objectForKey:@"destorTime"] longLongValue];
     for (NSDictionary * goodsDic in goodsList) {
     Product * product = [[Product alloc]initProductWithDic:goodsDic];
     */
    // 计算商品数量
    int numberOfPro = 0 ;
    for(int i = 0 ; i < order.productList.count ; i++){
        Product * pro = [ order.productList objectAtIndex:i ];
        numberOfPro = numberOfPro +  pro.count ;
    }
    
    NSString *goodsCount = [NSString stringWithFormat:@"%d", numberOfPro];
    self.goodsCount.text = goodsCount;
    self.goodsPrice.text = [NSString stringWithFormat:@"%0.2f", order.paidAmount];
    _orderDate = order.destorTime;
    
    [self timerFireMethod:nil];
    
    // 订单创建时间
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
}

#pragma mark - 设置定时器
- (void)timerFireMethod:(NSTimer *)timer
{    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    long long fireDateInt = _orderDate * 0.001;  // 结束时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSince1970:fireDateInt];
    NSDate *today = [NSDate date];//当前时间
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:today toDate:fireDate options:0];//计算时间差
    self.hour.text = [NSString stringWithFormat:@"%0.2d", [d hour]];
    self.minute.text = [NSString stringWithFormat:@"%0.2d", [d minute]];
    self.second.text = [NSString stringWithFormat:@"%0.2d", [d second]];
    
    
    // 倒计时失败的时候，停止timer，并返回状态，通知控制器刷新数据
    if (fireDateInt <= [[TimeStamp timeStamp] integerValue]) {
        self.hour.text = [NSString stringWithFormat:@"%0.2d", 0];
        self.minute.text = [NSString stringWithFormat:@"%0.2d", 0];
        self.second.text = [NSString stringWithFormat:@"%0.2d", 0];
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
        [timer invalidate];
        _timeOut = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(timerInvalidate)]) {
            [self.delegate timerInvalidate];
        }
    }
}

#pragma mark - 设置checkBox按钮
- (void)setCheckBoxButtonStatus:(BOOL)isChecked
{
    // 设置checkBox的状态
    NSString *imageName = !isChecked ? @"checkBox_normal" : @"checkBox_highlighted";
    _checkBoxStatus = isChecked;
    [_checkBoxButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}
#pragma mark - 按钮点击事件
- (void)ButtonAction:(id)sender
{
    // 设置checkBox的状态
    NSString *imageName = _checkBoxStatus ? @"checkBox_normal" : @"checkBox_highlighted";
    _checkBoxStatus = !_checkBoxStatus;
    [_checkBoxButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [_viewController performSelector:_cbAction withObject:self];
}

#pragma mark - TARGET_ACTION
- (void)addTarget:(id)target payAction:(SEL)payAction checkBoxAction:(SEL)cbAction cancelAction:(SEL)cAction
{
    _viewController = target;
    _payAction = payAction;
    _cbAction = cbAction;
    _cAction = cAction;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)dealloc
//{
//    [self.orderNumber release];
//    [self.goodsImage release];
//    [self.goodsPrice release];
//    [_checkBoxButton release];
//    [super dealloc];
//}
- (void)dealloc
{
    [_timer invalidate];
//    [_timer release];
    [super dealloc];
}

@end
