//
//  ShoppingCartCell.h
//  DBuyer
//
//  Created by chenpeng on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@interface ShoppingCartCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *productImageView;
@property (retain, nonatomic) IBOutlet UILabel *productNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (retain, nonatomic) IBOutlet UITextField *productCountTextField;
@property (retain, nonatomic) IBOutlet UIButton *selectButton;
@property (retain, nonatomic) IBOutlet UIImageView *selectImageView;
@property (retain, nonatomic) IBOutlet UIButton *joinPlanButton;

// 便利构造器方法
+ (id)shoppingCartCell;

// 显示一个商品实体
- (void)showWithProduct:(Product *)product;
// 返回一个cell的高度
+ (float)heightOfCell;
// 设置为选中状态
- (void)setSelectStatus:(BOOL)status;
// 自定义target action 方法
- (void)addTarget:(id)target
     selectAction:(SEL)selectAction
     deleteAction:(SEL)deleteAction
countChangeAction:(SEL)countChangeAction
   joinPlanAction:(SEL)joinPlanAction
beginEditingAction:(SEL)beginEditingAction;

// 选择按钮点击事件
- (IBAction)selectButtonClicked:(UIButton *)sender;
// 删除按钮点击事件
- (IBAction)deleteButtonClicked:(UIButton *)sender;
// 加入计划按钮点击事件
- (IBAction)joinPlanButtonClicked:(UIButton *)sender;
@end
