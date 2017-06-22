//
//  TAllscoOrderChargeCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderChargeCell.h"

#define labelFont_size_one  17

@implementation TAllscoOrderChargeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _chargeCardNoTitle = [[UILabel alloc]init];
    _chargeCardNoTitle.font = [UIFont boldSystemFontOfSize:labelFont_size_one];
    [_chargeCardNoTitle setTextColor:[UIColor blackColor]];
    [_chargeCardNoTitle setBackgroundColor:[UIColor clearColor]];
    _chargeCardNoTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_chargeCardNoTitle];
    
    _chargeCardNo = [[UILabel alloc]init];
    _chargeCardNo.font = [UIFont systemFontOfSize:labelFont_size_one];
    [_chargeCardNo setTextColor:[UIColor colorWithRed:47/255.0 green:64/255.0 blue:107/255.0 alpha:1.0]];
    [_chargeCardNo setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_chargeCardNo];
    
    _chargeAmtTitle = [[UILabel alloc]init];
    _chargeAmtTitle.font = [UIFont boldSystemFontOfSize:labelFont_size_one];
    [_chargeAmtTitle setTextColor:[UIColor blackColor]];
    [_chargeAmtTitle setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_chargeAmtTitle];
    
    _chargeAmt = [[UILabel alloc]init];
    _chargeAmt.font = [UIFont systemFontOfSize:labelFont_size_one];
    [_chargeAmt setTextColor:[UIColor redColor]];
    [_chargeAmt setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_chargeAmt];
    
    return self;
}

+(float)heightForCell {
    return 60;
}

- (void)setDataForCell:(TAllScoCharge*)chargeForm {
    [_chargeCardNoTitle setText:@"储值卡号:"];
    CGSize maximumLabelSize = CGSizeMake(100, 999);
    CGSize titleSize = [_chargeCardNoTitle.text sizeWithFont:_chargeCardNoTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_chargeCardNoTitle setFrame:CGRectMake(15, 10, titleSize.width, titleSize.height)];
    
    [_chargeCardNo setText:chargeForm.cardNumber];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_chargeCardNo.text sizeWithFont:_chargeCardNo.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_chargeCardNo setFrame:CGRectMake(_chargeCardNoTitle.frame.origin.x+_chargeCardNoTitle.frame.size.width+10, _chargeCardNoTitle.frame.origin.y, titleSize.width, titleSize.height)];
    
    [_chargeAmtTitle setText:@"储值金额:"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_chargeAmtTitle.text sizeWithFont:_chargeAmtTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_chargeAmtTitle setFrame:CGRectMake(_chargeCardNoTitle.frame.origin.x,[TAllscoOrderChargeCell heightForCell]-5-titleSize.height, titleSize.width, titleSize.height)];
    
    [_chargeAmt setText:[NSString stringWithFormat:@"￥%@",chargeForm.chargeAmount]];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_chargeAmtTitle.text sizeWithFont:_chargeAmtTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_chargeAmt setFrame:CGRectMake(_chargeCardNoTitle.frame.origin.x+_chargeCardNoTitle.frame.size.width+10,[TAllscoOrderChargeCell heightForCell]-5-titleSize.height, titleSize.width, titleSize.height)];
    //
}

@end
