//
//  DropdownRefreshView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdownRefreshView : UIView

@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UIImageView *loadingImageView;


+ (id)dropdownRefreshView;

// 开始加载动画
- (void)startAnimation:(BOOL)start;
// 设置显示最近刷新时间
- (void)setRefreshTime:(NSDate *)date;
@end
