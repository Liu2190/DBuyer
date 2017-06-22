//
//  TBuyerTableCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-30.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBuyerTableCell.h"

#define labelFont_size_one      16
#define labelFont_size_two      16
#define labelFont_size_three    14

#define line_width  2

@implementation TBuyerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    CGRect rect = CGRectMake((self.contentView.frame.size.width-line_width)/2, 10, line_width, [TBuyerTableCell heightForCell]-20);
    _lineImageView = [[UIImageView alloc]initWithFrame:rect];
    [_lineImageView setImage:[UIImage imageNamed:@"AllScoGood_BuyLine.png"]];
    [self.contentView addSubview:_lineImageView];
    
    _cardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, self.frame.size.width/2-30, [TBuyerTableCell heightForCell]-20)];
    [self.contentView addSubview:_cardImageView];
    
    _cardTitleLabel = [[UILabel alloc]init];
    _cardTitleLabel.font = [UIFont systemFontOfSize:labelFont_size_one];
    [_cardTitleLabel setTextColor:[UIColor blackColor]];
    [_cardTitleLabel setBackgroundColor:[UIColor clearColor]];
    _cardTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_cardTitleLabel];
    
    _moneyLabel = [[UILabel alloc]init];
    _moneyLabel.font = [UIFont systemFontOfSize:labelFont_size_two];
    _moneyLabel.textAlignment = NSTextAlignmentRight;
    [_moneyLabel setTextColor:[UIColor blackColor]];
    [_moneyLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_moneyLabel];
    
    _numberLabel = [[UILabel alloc]init];
    _numberLabel.textAlignment = NSTextAlignmentRight;
    _numberLabel.font = [UIFont systemFontOfSize:labelFont_size_two];
    [_numberLabel setTextColor:[UIColor blackColor]];
    [_numberLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_numberLabel];
    
    _subTotalLabel = [[UILabel alloc]init];
    _subTotalLabel.textAlignment = NSTextAlignmentRight;
    _subTotalLabel.font = [UIFont systemFontOfSize:labelFont_size_three];
    [_subTotalLabel setTextColor:[UIColor redColor]];
    [_subTotalLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_subTotalLabel];
    
    return self;
}

- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm {
    [_cardImageView setImageWithURL:[NSURL URLWithString:goodsForm.allscoImageUrl]];
    
    [_cardTitleLabel setText:goodsForm.allscoTitle];
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    CGSize titleSize = [_cardTitleLabel.text sizeWithFont:_cardTitleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_cardTitleLabel setFrame:CGRectMake(self.frame.size.width/2+15, 10, titleSize.width, titleSize.height)];
    
    [_moneyLabel setText:[NSString stringWithFormat:@"￥%@",goodsForm.sellPrice]];
    titleSize = [_moneyLabel.text sizeWithFont:_moneyLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_moneyLabel setFrame:CGRectMake(self.frame.size.width/2+15, _cardTitleLabel.frame.size.height+_cardTitleLabel.frame.origin.y+5, titleSize.width, titleSize.height)];
    
    
    [_numberLabel setText:[NSString stringWithFormat:@"x%i",goodsForm.sellNumber]];
    titleSize = [_numberLabel.text sizeWithFont:_numberLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_numberLabel setFrame:CGRectMake(_moneyLabel.frame.origin.x+_moneyLabel.frame.size.width+10, _moneyLabel.frame.origin.y, titleSize.width, titleSize.height)];
    

    [_subTotalLabel setText:[NSString stringWithFormat:@" %@",[goodsForm getTotalMoney]]];
    titleSize = [_subTotalLabel.text sizeWithFont:_subTotalLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_subTotalLabel setFrame:CGRectMake(0, [TBuyerTableCell heightForCell]-5-titleSize.height, titleSize.width, titleSize.height)];
    
    UILabel *xiaojiLabel = [[[UILabel alloc]init]autorelease];
    xiaojiLabel.textAlignment = NSTextAlignmentRight;
    xiaojiLabel.font = [UIFont systemFontOfSize:labelFont_size_three];
    [xiaojiLabel setTextColor:[UIColor blackColor]];
    [xiaojiLabel setBackgroundColor:[UIColor clearColor]];
    [xiaojiLabel setText:@"小计:"];
    titleSize = [xiaojiLabel.text sizeWithFont:xiaojiLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [xiaojiLabel setFrame:CGRectMake(self.frame.size.width-15-_subTotalLabel.frame.size.width-titleSize.width, [TBuyerTableCell heightForCell]-10-titleSize.height, titleSize.width, titleSize.height)];
    [self.contentView addSubview:xiaojiLabel];
    
    [_subTotalLabel setFrame:CGRectMake(self.frame.size.width-15-_subTotalLabel.frame.size.width, [TBuyerTableCell heightForCell]-10-titleSize.height, _subTotalLabel.frame.size.width, _subTotalLabel.frame.size.height)];
}

+ (float)heightForCell {
    return 100;
}

- (void)dealloc {
    [super dealloc];
    [_cardImageView release];
    _cardImageView = nil;
    
    [_cardTitleLabel release];
    _cardTitleLabel = nil;
    
    [_moneyLabel release];
    _moneyLabel = nil;
    
    [_numberLabel release];
    _numberLabel = nil;
    
    [_subTotalLabel release];
    _subTotalLabel = nil;
}

@end
