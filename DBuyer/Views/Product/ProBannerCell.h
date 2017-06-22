//
//  ProBannerCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
@interface ProBannerCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *collectButton;
@property (retain, nonatomic) IBOutlet UIImageView *photoImage;
-(void)setProBannerCellWith:(ProductDetail *)product;
-(void)collectAnimation;
@end