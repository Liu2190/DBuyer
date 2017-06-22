//
//  ProButtonCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProButtonCell.h"

@implementation ProButtonCell

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
    self.userInteractionEnabled = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellValueWith:(ProductDetail *)product
{
    if([product.realInventory intValue]==0)
    {
        self.gouwucheButton.userInteractionEnabled = NO;
        [self.gouwucheButton setImage:[UIImage imageNamed:@"pro_buttonDisabel"] forState:UIControlStateNormal];
        self.lijigoumaiButton.userInteractionEnabled = NO;
        [self.lijigoumaiButton setImage:[UIImage imageNamed:@"pro_buttonDisabel"] forState:UIControlStateNormal];
    }
    self.jihuaButton.userInteractionEnabled = !product.isPlan;
    if(product.isPlan)
    {
        [self.jihuaButton setImage:[UIImage imageNamed:@"pro_buttonDisabel"] forState:UIControlStateNormal];
    }
}

@end
