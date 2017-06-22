//
//  NavigationBarView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "NavigationBarView.h"

@interface NavigationBarView () {
    CGFloat startPoint;
}

@end

@implementation NavigationBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_titleLabel release];
    [_titleImageView release];
    [_leftButtonImageView release];
    [_leftButton release];
    [_rightButtonImageView release];
    [_rightButton release];
    [super dealloc];
}

+ (id)navigationBarView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"NavigationBarView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    // 屏幕适配
    [self setStartPoint];
    CGRect frame = self.frame;
    frame.origin.y = startPoint;
    self.frame = frame;
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

- (void)setLeftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage titleImage:(UIImage *)titleImage title:(NSString *)title
{
    self.leftButtonImageView.image = leftImage;
    if (leftImage == nil) {
        self.leftButton.enabled = NO;
    } else {
        self.leftButton.enabled = YES;
    }
    self.rightButtonImageView.image = rightImage;
    if (rightImage == nil) {
        self.rightButton.enabled = NO;
    } else {
        self.rightButton.enabled = YES;
    }
    self.titleImageView.image = titleImage;
    self.titleLabel.text = title;
}

- (IBAction)leftButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarDidClickButton:)]) {
        [self.delegate navigationBarDidClickButton:0];
    }
}

- (IBAction)rightButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationBarDidClickButton:)]) {
        [self.delegate navigationBarDidClickButton:1];
    }

}
@end
