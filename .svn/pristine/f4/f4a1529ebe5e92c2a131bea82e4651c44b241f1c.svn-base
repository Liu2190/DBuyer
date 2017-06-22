//
//  ProServiceCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProServiceCell.h"

@implementation ProServiceCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellValueWith:(NSString *)service
{
    self.salesLabel.text = service;
    CGRect frame = self.salesLabel.frame;
    float width = frame.size.width;
    frame.size.height = [self heightForString:service font:self.salesLabel.font andWidth:width].height;
    self.salesLabel.frame = frame;
}
-(CGSize)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit;
}
- (void)dealloc {
    [_salesLabel release];
    [super dealloc];
}
@end
