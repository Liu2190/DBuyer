//
//  ProDetailsView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
@interface ProDetailsView : UIView

@property (retain, nonatomic) IBOutlet UIImageView *arrowImage;
@property (retain, nonatomic) IBOutlet UILabel *proName;
@property (retain, nonatomic) IBOutlet UILabel *sellPrice;
@property (retain, nonatomic) IBOutlet UILabel *marketPrice;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage1;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage2;
@property (retain, nonatomic) IBOutlet UIImageView *bqImage3;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel1;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel2;
@property (retain, nonatomic) IBOutlet UILabel *bqLabel3;
@property (retain, nonatomic) IBOutlet UILabel *cuxiaoLabel;
@property (retain, nonatomic) IBOutlet UILabel *kucunLabel;
@property (retain, nonatomic) IBOutlet UIButton *spreadButton;
@property (retain, nonatomic) IBOutlet UILabel *moneySymbol;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImage;
-(void)setProDetailViewWith:(ProductDetail *)product;
-(float )getHeight:(ProductDetail *)product;
-(float)heightOfPro;
@end
