//
//  ProToCartButton.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-22.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProToCartButton : UIView
@property (retain, nonatomic) IBOutlet UIImageView *cartImageView;
@property (retain, nonatomic) IBOutlet UILabel *numLabel;
@property (retain, nonatomic) IBOutlet UIImageView *redImageView;
-(void)setShoppingCartNumWith:(NSInteger)num;

@end
