//
//  ProductCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface ProductCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *productName;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;
@property (retain, nonatomic) IBOutlet UILabel *sellPrice;
@property (retain, nonatomic) IBOutlet UILabel *marketPrice;
@property (retain, nonatomic) IBOutlet UILabel *discription;
@property (retain, nonatomic) IBOutlet UIImageView *deleteLine;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage1;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage2;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage3;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel1;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel2;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel3;
- (void)showWithProduct:(Product *)product;
@end
