//
//  AddAddressBtnCell.m
//  DBuyer
//  添加地址按钮cell
//  Created by lixinda on 13-11-22.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AddAddressBtnCell.h"
#import "BtnDelegate.h"

@implementation AddAddressBtnCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = BACKCOLOR;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
