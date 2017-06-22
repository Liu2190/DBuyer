//
//  CharacteristicCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CharacteristicCell.h"

@implementation CharacteristicCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)characteristicCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CharacteristicCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithRed:239/255.0 green:237/255.0 blue:216/255.0 alpha:1];
}

+ (CGFloat)heightOfCell
{
    return 57.0f;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_iconImageView release];
    [_titleLabel release];
    [_subTitleLabel release];
    [_nextButton release];
    [super dealloc];
}
@end
