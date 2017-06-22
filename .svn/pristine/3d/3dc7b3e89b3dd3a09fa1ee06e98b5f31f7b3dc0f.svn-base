//
//  ProductListTopView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol productListTopViewDelegate<NSObject>
-(void)productListTopViewDidClick:(int)num;
@end

@interface ProductListTopView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *xinpin;
@property (retain, nonatomic) IBOutlet UIImageView *xiaoliang;
@property (retain, nonatomic) IBOutlet UIImageView *jiage;
@property (nonatomic,assign)id<productListTopViewDelegate> delegate;
-(void)setButtonImageWith:(int)num And:(BOOL)priceStatus;
@end
