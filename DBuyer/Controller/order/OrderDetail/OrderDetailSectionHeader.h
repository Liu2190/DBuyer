//
//  OrderDetailSectionHeader.h
//  DBuyer
//
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailSectionHeader : UIView


@property (retain, nonatomic) IBOutlet UILabel     *titleLable; // 标题
@property (retain, nonatomic) IBOutlet UILabel     *contentLable; //内容
@property (retain, nonatomic) IBOutlet UIImageView *backGroundView; // 背景

/**
 *  设置内容
 *
 *  @param title   标题
 *  @param content 内容
 */
- (void)setHeaderViewDataWithTitle:(NSString *)title content:(NSString *)content;

@end
