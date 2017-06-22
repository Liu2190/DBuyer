//
//  TUserCenterCell_2.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterCell_2.h"

@implementation TUserCenterCell_2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_titleLabel];

    return self;
}

- (void)setDataForCell:(TRowModel *)rowModel {
    [super setDataForCell:rowModel];
    
    NSString *title = [rowModel.datas objectForKey:@"title"];
    _titleLabel.text = title;
    
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_titleLabel setFrame:CGRectMake(20, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
}

- (void)dealloc {
    [super dealloc];
    [_titleLabel release];
    _titleLabel = nil;
}

@end
