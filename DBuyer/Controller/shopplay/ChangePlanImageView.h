//
//  ChangePlanImageView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeIconDelegate <NSObject>

@optional

-(void)iconButtonDidClick:(UIButton *)button;

@end
@interface ChangePlanImageView : UIView
@property(nonatomic,assign)id CPIdelegate;
-(id)initWithBackImageView:(CGRect )frame;

@end
