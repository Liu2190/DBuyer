//
//  SearchBarView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SearchBarView.h"

@interface SearchBarView () {
    CGFloat startPoint;
}

@end

@implementation SearchBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_searchButton release];
    [_zoomImageView release];
    [_placeHolderLabel release];
    [_leftButtonImageView release];
    [_leftButton release];
    [_rightButtonImageView release];
    [_rightButton release];
    [super dealloc];
}

+ (id)searchBarView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SearchBarView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    // 屏幕适配
    [self setStartPoint];
    CGRect frame = self.frame;
    frame.origin.y = startPoint;
    self.frame = frame;
    
    // 设置默认视图
    self.rightButton.enabled = NO;
    self.rightButtonImageView.hidden = YES;
}

-(void)setStartPoint
{
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending) {
        startPoint = -20.0f;
        //当前系统小于IOS7.0
    }
    else
    {
        startPoint = 0.0f;
        //当前系统大于ios7.0
    }
}

- (CGFloat)bottom
{
    return startPoint + self.frame.size.height;
}

- (void)placeholderShow:(NSString *)string
{
    self.placeHolderLabel.text = string;
}

- (void)showLeftButton:(BOOL)show
{
    if (show) {
        self.leftButton.enabled = YES;
        self.leftButtonImageView.hidden = NO;
    } else {
        self.leftButton.enabled = NO;
        self.leftButtonImageView.hidden = YES;
    }
}

- (void)showRightButton:(BOOL)show
{
    if (show) {
        self.rightButton.enabled = YES;
        self.rightButtonImageView.hidden = NO;
    } else {
        self.rightButton.enabled = NO;
        self.rightButtonImageView.hidden = YES;
    }
}

- (IBAction)searchButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidClickButton:)]) {
        [self.delegate searchBarDidClickButton:1];
    }
}

- (IBAction)leftButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidClickButton:)]) {
        [self.delegate searchBarDidClickButton:0];
    }
}

- (IBAction)rightButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidClickButton:)]) {
        [self.delegate searchBarDidClickButton:2];
    }
}
@end
