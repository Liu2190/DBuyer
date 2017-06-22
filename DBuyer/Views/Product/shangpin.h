//
//  shangpin.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-31.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface shangpin : UIView
//@property (retain, nonatomic) IBOutlet UIImageView *img;
//@property (retain, nonatomic) IBOutlet UILabel *titlelabel;
//@property (retain, nonatomic) IBOutlet UILabel *jiage;

@property (retain, nonatomic) IBOutlet UIImageView *productImageView;
@property (retain, nonatomic) IBOutlet UILabel *productNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *productPriceLabel;



+ (id)shangPin;

- (void)showWithProduct:(Product *)product;

@end
