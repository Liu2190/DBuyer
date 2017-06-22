//
//  FinishOrderCell.m
//  DBuyer
//
//  Created by simman on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "FinishOrderCell.h"
#import "Product.h"
@interface FinishOrderCell() {
    id _viewController;    // 控制器
    SEL _select;           // 要执行的方法
}

@end

@implementation FinishOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (FinishOrderCell *)initWithNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FinishOrderCell" owner:nil options:nil] lastObject];
}

- (void)setFinishOrderCellType:(CELLTYPE)type
{
    if (type == FINISHORDERCELL) {
        [[self planButton] setHidden : NO];
        [[self selectLogistics] setHidden : YES];
    } else {
        [[self planButton] setHidden:YES];
        [[self selectLogistics] setHidden:NO];
    }
}

#pragma mark - 设置cell的值
- (void)setCellValue:(Product *)product orderID:(NSString *)orderId orderCount:(NSString *)orderCount
{
    self.orderNumber.text = product.catID;
    self.goodsImage.image = [UIImage imageNamed:product.attrValue];
    self.goodsTitle.text = product.commodityName;
    self.goodsCount.text = orderCount;
    self.goodsPrice.text = [NSString stringWithFormat:@"%f", product.sellPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - TARGET_ACTION
- (void)addTarget:(id)target Action:(SEL)select
{
    _viewController = target;
    _select = select;
}

#pragma mark 按钮点击事件


- (IBAction)ButtonAction:(id)sender
{
   [_viewController performSelector:_select withObject:_indexPath];
}

@end
