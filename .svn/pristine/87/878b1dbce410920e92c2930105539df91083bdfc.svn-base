//
//  CategorySection.h
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategorySection : UIView


@property (retain, nonatomic) IBOutlet UIImageView *cateGoryImage; // 分类图片
@property (retain, nonatomic) IBOutlet UILabel *categoryTitle; // 分类标题
@property (retain, nonatomic) IBOutlet UILabel *categoryContent; //分类内容
@property (retain, nonatomic) IBOutlet UIImageView *arrowsImageView;
- (IBAction)sectionButtonAction:(id)sender; //点击Section事件

@property (assign, nonatomic) NSInteger sectionIndex;               // Section的path
@property (nonatomic ,assign) BOOL isClicked; // 是否被选中

- (void)addMyTarget:(id)target Action:(SEL)action;

- (id)initWithTitle:(NSString *)title content:(NSString *)content image:(NSString *)image target:(id)target action:(SEL)action;


@end
