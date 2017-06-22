//
//  TTabBarBlock.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTabBarBlock : UIView {
    UIButton *_btn;
    UILabel *_tabBarLabel;
}

/**
 * 被选择的颜色样式
 */
@property (nonatomic,retain)UIColor *colorSelected;
@property (nonatomic,retain)UIColor *colorDefault;

- (id)initWithFrame:(CGRect)frame andItemName:(NSString*)itemName andIndex:(int)index;
- (void)setActionForTarget:(id)target;

- (void)updateCompentByisSelect:(BOOL)isSelect;

@end
