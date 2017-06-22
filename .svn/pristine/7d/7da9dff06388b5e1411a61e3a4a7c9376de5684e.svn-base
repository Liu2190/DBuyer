//
//  CollectEditCell.h
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface CollectEditCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *productImageView;
@property (retain, nonatomic) IBOutlet UILabel *productNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (retain, nonatomic) IBOutlet UIButton *joinPlanButton;

- (IBAction)deleteButtonClicked:(UIButton *)sender;
- (IBAction)joinPlanButtonClicked:(UIButton *)sender;

// 自定义target action
- (void)addtarget:(id)target
     deleteAction:(SEL)deleteAction
   joinPlanAction:(SEL)joinPlanAction;

- (void)showWithProduct:(Product *)product;
+ (id)collectEditCell;
+ (float)heightOfCell;
@end
