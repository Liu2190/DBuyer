//
//  SettlementProductCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface SettlementProductCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *totalPrice;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *proName;
@property (retain, nonatomic) IBOutlet UILabel *count;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;
-(void)setCellValueWith:(Product *)product;
@end
