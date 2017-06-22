//
//  FinishOrderCell.h
//  DBuyer
//
//  Created by simman on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//  2014/01/03   liwei
// 每个订单单独显示成一个cell，cell里面的产品是订单中的第一个产品，数量是订单中所有产品的数量

#import <UIKit/UIKit.h>
@class Product;
typedef enum  {
	FINISHORDERCELL = 0,    // 已经完成
    ORDERCONSIGNEE          // 待收货
} CELLTYPE;

@interface FinishOrderCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *orderNumber; // 订单编号
@property (retain, nonatomic) IBOutlet UIImageView *goodsImage; // 订单图片
@property (retain, nonatomic) IBOutlet UILabel *goodsTitle; // 商品名称
@property (retain, nonatomic) IBOutlet UILabel *goodsCount; // 订单中所有商品数量
@property (retain, nonatomic) IBOutlet UILabel *goodsPrice; // 商品价格
@property (assign, nonatomic) CELLTYPE cellType;            // cell 类型
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, retain) Product *order;

@property (retain, nonatomic) IBOutlet UIButton *planButton;        // 计划按钮
@property (retain, nonatomic) IBOutlet UIButton *selectLogistics;   // 查看物流按钮

- (void)setCellValue:(Product *)product orderID:(NSString *)orderId orderCount:(NSString *)orderCount; // 设置cell的值
- (IBAction)ButtonAction:(id)sender; // 按钮事件
+ (FinishOrderCell *)initWithNib;
- (void)setFinishOrderCellType:(CELLTYPE)type;
- (void)addTarget:(id)target Action:(SEL)select;        // 按钮回调
@end

