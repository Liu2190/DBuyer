//
//  DropdownRefreshView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "DropdownRefreshView.h"

@implementation DropdownRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)dropdownRefreshView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DropdownRefreshView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    // 设置背景颜色
    self.backgroundColor = BACKCOLOR;
    // 设置加载动画
    self.loadingImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Image_RefreshView_00"],
                                                                      [UIImage imageNamed:@"Image_RefreshView_01"],
                                                                      [UIImage imageNamed:@"Image_RefreshView_02"],
                                                                      [UIImage imageNamed:@"Image_RefreshView_03"], nil];
    self.loadingImageView.animationDuration = 0.8;
    self.loadingImageView.animationRepeatCount = 0;
    [self.loadingImageView stopAnimating];
}

- (void)setRefreshTime:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"MM.dd hh:mm a"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    [formatter release];
}

- (void)startAnimation:(BOOL)start
{
    if (start) {
        [self.loadingImageView startAnimating];
    } else {
        [self.loadingImageView stopAnimating];
    }
}

- (void)dealloc {
    [_timeLabel release];
    [_loadingImageView release];
    [super dealloc];
}
@end
