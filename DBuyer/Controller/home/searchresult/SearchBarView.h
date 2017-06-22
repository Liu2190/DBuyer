//
//  SearchBarView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchBarViewDelegate <NSObject>

// 0 -> leftButton
// 1 -> searchButton
// 2 -> rightButton
- (void)searchBarDidClickButton:(NSInteger)buttonIndex;

@end

@interface SearchBarView : UIView

@property (assign, nonatomic) id <SearchBarViewDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIButton *searchButton;
// 放大镜图片
@property (retain, nonatomic) IBOutlet UIImageView *zoomImageView;
// 搜索框中显示的信息
@property (retain, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (retain, nonatomic) IBOutlet UIImageView *leftButtonImageView;
@property (retain, nonatomic) IBOutlet UIButton *leftButton;
@property (retain, nonatomic) IBOutlet UIImageView *rightButtonImageView;
@property (retain, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)searchButtonClicked:(UIButton *)sender;
- (IBAction)leftButtonClicked:(id)sender;
- (IBAction)rightButtonClicked:(id)sender;

// 便利构造器方法
+ (id)searchBarView;
- (CGFloat)bottom;

// 设置输入框显示
- (void)placeholderShow:(NSString *)string;

// 默认显示 leftButton, 隐藏 rightButton
// 显示 rightButton
- (void)showRightButton:(BOOL)show;
// 显示 leftButton
- (void)showLeftButton:(BOOL)show;

@end