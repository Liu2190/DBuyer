//
//  WaitBuyerPayOrderCell.h
//  DBuyer
//
//  Created by simman on 14-1-4.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GoPayButtonTag  9001            // 去付款按钮
#define checkBoxButtonTag   9002        // 复选框按钮
@protocol  WaitBuyerPayOrderCellDelegate<NSObject>
- (void)timerInvalidate;    // 计时器关闭事件
@end
@class Product;
@class Order;
@interface WaitBuyerPayOrderCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *orderNumber; // 订单编号
@property (retain, nonatomic) IBOutlet UIImageView *goodsImage; // 订单图片
@property (retain, nonatomic) IBOutlet UILabel *goodsTitle; // 商品名称
@property (retain, nonatomic) IBOutlet UILabel *goodsCount; // 订单中所有商品数量
@property (retain, nonatomic) IBOutlet UILabel *goodsPrice; // 商品价格
@property (retain, nonatomic) IBOutlet UIButton *goPayButton;        // 去付款按钮
@property (retain, nonatomic) IBOutlet UILabel *hour;       // 小时数
@property (retain, nonatomic) IBOutlet UILabel *minute;     // 分钟
@property (retain, nonatomic) IBOutlet UILabel *second;     // 秒
@property (nonatomic, assign) BOOL timeOut;                 // 超时
@property (nonatomic, retain) id <WaitBuyerPayOrderCellDelegate>delegate;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) Order *order;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (IBAction)ButtonAction:(id)sender; // 按钮事件

- (IBAction)orderCancelAction:(id)sender;   // 取消订单事件

- (IBAction)goPayButtonAction:(id)sender; // 支付按钮事件

- (WaitBuyerPayOrderCell *)initWithNib;

- (void)setCheckBoxButtonStatus:(BOOL)isChecked;

- (void)addTarget:(id)target payAction:(SEL)select checkBoxAction:(SEL)cbAction cancelAction:(SEL)cAction;        // 按钮回调
@property (retain, nonatomic) IBOutlet UIButton *checkBoxButton;    // 选中按钮

- (void)setCellValue:(Order *)order;// 设置Cell的值

@end
