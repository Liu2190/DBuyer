//
//  UserFBContentCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-4.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "UserFBContentCell.h"

@implementation UserFBContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(float)userFBContentCellHeight
{
    return 250.0f;
}
- (void)dealloc {
    [_contentTextView release];
    [super dealloc];
}
@end
