//
//  SettlementReceiverCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementReceiverCell.h"

@implementation SettlementReceiverCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_receiverLabel release];
    [_phoneLabel release];
    [_addressLabel release];
    [super dealloc];
}
-(void)setCellValueWith:(AddressItem *)address
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.receiverLabel.text = address.name;
    self.phoneLabel.text = address.phoneNumber;
    self.addressLabel.text = address.address;
    CGRect frame = self.addressLabel.frame;
    frame.size.height = [self heightForString:address.address font:self.addressLabel.font andWidth:frame.size.width].height;
    self.addressLabel.frame = frame;
}
-(CGSize)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit;
}
+(float)cellHeightWith:(NSString *)string
{
    CGSize sizeToFit = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(233, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return 49+sizeToFit.height;
}
@end
