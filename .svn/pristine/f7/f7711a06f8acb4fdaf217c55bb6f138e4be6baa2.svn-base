
//
//  CategorySection.m
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CategorySection.h"

#define BACKGROUND_COLOR [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1]

@interface CategorySection() {
    id _target;
    SEL _action;
}

@end

@implementation CategorySection

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addMyTarget:(id)target Action:(SEL)action
{
    _target = target;
    _action = action;
}

#pragma mark 初始化方法
- (id)initWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)image target:(id)target action:(SEL)action
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CategorySection" owner:nil options:nil] lastObject];
     _isClicked = NO;
    self.categoryTitle.text = title;
    self.categoryContent.text = content;
    [self.cateGoryImage setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placeHolerImage44"]];
    self.cateGoryImage.frame=self.cateGoryImage.frame;
    _target = target;
    _action = action;
    self.backgroundColor = BACKGROUND_COLOR;
    return self;
}
#pragma mark 点击Section的事件
- (IBAction)sectionButtonAction:(id)sender {
    [_target performSelector:_action withObject:self];
}

- (void)dealloc {
    [_cateGoryImage release];
    [_categoryTitle release];
    [_categoryContent release];
    [_arrowsImageView release];
    [super dealloc];
}

@end
