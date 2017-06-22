//
//  ActiveView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@protocol activeDidClickDelegate
-(void)activeDidClick:(int )index;
@end
@interface ActiveView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *activeProImage;
@property (retain, nonatomic) IBOutlet UILabel *activeNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *activePriceLabel;
@property (retain, nonatomic) IBOutlet UIImageView *backImage;
@property (retain, nonatomic) IBOutlet UILabel *marketPrice;
@property (retain, nonatomic) IBOutlet UIImageView *deleteImage;

@property (nonatomic,assign)id delegate;
-(void)setActiveViewValueWith:(Product *)product AndIndex:(int )index;

@end
