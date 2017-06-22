//
//  CategoryCell.h
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *categoryImage; // 分类图片
@property (retain, nonatomic) IBOutlet UILabel *specialTitle; // 专题Title
@property (retain, nonatomic) IBOutlet UILabel *categoryTitle; // 分类title
@property (retain, nonatomic) IBOutlet UILabel *categoryContent; // 分类内容
@property (retain, nonatomic) IBOutlet UIButton *arrowsButton; // 箭头按钮


#pragma mark 专场cell赋值
- (id)initWithSpecialTitle:(NSString *)title image:(NSString *)image;
#pragma mark 普通cell赋值
- (id)initWithTitle:(NSString *)title content:(NSString *)content pic_url:(NSString *)pic_url;

@end
