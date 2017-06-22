//
//  CategoryCell.m
//  DBuyer
//
//  Created by simman on 14-1-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CategoryCell.h"

#define BACKGROUND_COLOR [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]

@implementation CategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleNone; // 选中样式
    self.backgroundColor = BACKGROUND_COLOR;
    self.contentView.backgroundColor=BACKGROUND_COLOR;
}

- (id)initWithSpecialTitle:(NSString *)title image:(NSString *)image
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil] lastObject];
    self.specialTitle.text = title;
    [self.categoryImage setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placeHolerImage44"]];
    
    self.categoryTitle.hidden = YES;
    self.categoryContent.hidden = YES;
    [self setCellStyle];
    
    return self;
}

- (id)initWithTitle:(NSString *)title content:(NSString *)content pic_url:(NSString *)pic_url
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:nil options:nil] lastObject];
    self.categoryTitle.text = title;
    self.categoryContent.text = content;
    self.specialTitle.hidden = YES;
    if([content length]==0)
    {
        self.categoryTitle.frame = CGRectMake(90, 15, 183, 21);
    }
    [self.categoryImage setImageWithURL:[NSURL URLWithString:pic_url]placeholderImage:[UIImage imageNamed:@"placeHolerImage44"]];
    [self setCellStyle];
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_categoryImage release];
    [_specialTitle release];
    [_categoryTitle release];
    [_categoryContent release];
    [_arrowsButton release];
    [super dealloc];
}
@end
