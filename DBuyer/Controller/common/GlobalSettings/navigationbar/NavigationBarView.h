//
//  NavigationBarView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationBarViewDelegate <NSObject>


// 0 -> leftButton
// 1 -> rightButton
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex;

@end

@interface NavigationBarView : UIView

@property (retain, nonatomic) id <NavigationBarViewDelegate> delegate;

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *titleImageView;
@property (retain, nonatomic) IBOutlet UIImageView *leftButtonImageView;
@property (retain, nonatomic) IBOutlet UIButton *leftButton;
@property (retain, nonatomic) IBOutlet UIImageView *rightButtonImageView;
@property (retain, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)leftButtonClicked:(UIButton *)sender;
- (IBAction)rightButtonClicked:(UIButton *)sender;

// 便利构造器方法
+ (id)navigationBarView;

// navigationBar 底部坐标
- (CGFloat)bottom;

- (void)setLeftImage:(UIImage *)leftImage
          rightImage:(UIImage *)rightImage
          titleImage:(UIImage *)titleImage
               title:(NSString *)title;

@end
