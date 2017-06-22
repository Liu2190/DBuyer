//
//  CollectCell.h
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface CollectCell : UITableViewCell
// 商品图片
@property (retain, nonatomic) IBOutlet UIImageView *productImageView;
// 商品名
@property (retain, nonatomic) IBOutlet UILabel *productNameLabel;
// 商品价格
@property (retain, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (retain, nonatomic) IBOutlet UILabel *productDealLabel;

@property (retain, nonatomic) IBOutlet UILabel *productRefPriceNameLabel;
// 商品参考价
// 参考价上得删除线
@property (retain, nonatomic) IBOutlet UILabel *deleteLineLabel;
// 显示商品keyWord
@property (retain, nonatomic) IBOutlet UILabel *productKeyWordLabel1;
@property (retain, nonatomic) IBOutlet UIImageView *productKeyWordImageView1;
@property (retain, nonatomic) IBOutlet UILabel *productKeyWordLabel2;
@property (retain, nonatomic) IBOutlet UIImageView *productKeyWordImageView2;
@property (retain, nonatomic) IBOutlet UILabel *productKeyWordLabel3;
@property (retain, nonatomic) IBOutlet UIImageView *productKeyWordImageView3;

@property (retain, nonatomic) IBOutlet UILabel *productDescripLabel;//商品描述或说明

// 便利构造器
+ (id)collectCell;

// cell高度
+ (float)heightOfCell;

// 显示商品
- (void)showWithProduct:(Product *)product;

@end
