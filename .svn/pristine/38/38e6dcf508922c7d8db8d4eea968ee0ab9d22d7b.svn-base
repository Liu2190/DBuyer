//
//  TAllscoOrderBuyerCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderBuyerCell.h"

#define labelFont_size_one  16

#define line_width  2

@implementation TAllscoOrderBuyerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    CGRect rect = CGRectMake((self.contentView.frame.size.width-line_width)/2, 10, line_width, [TAllscoOrderBuyerCell heightForCell]-20);
    _lineImageView = [[UIImageView alloc]initWithFrame:rect];
    [_lineImageView setImage:[UIImage imageNamed:@"AllScoGood_BuyLine.png"]];
    [self.contentView addSubview:_lineImageView];
    
    _faceAmtTitel = [[UILabel alloc]init];
    _faceAmtTitel.font = [UIFont systemFontOfSize:labelFont_size_one];
    [_faceAmtTitel setTextColor:[UIColor blackColor]];
    [_faceAmtTitel setBackgroundColor:[UIColor clearColor]];
    _faceAmtTitel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_faceAmtTitel];
    
    [_faceAmtTitel setText:@"卡面金额:"];
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    CGSize titleSize = [_faceAmtTitel.text sizeWithFont:_faceAmtTitel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_faceAmtTitel setFrame:CGRectMake(self.frame.size.width/2+15, 10, titleSize.width, titleSize.height)];
    
    _faceAmt = [[UILabel alloc]init];
    _faceAmt.font = [UIFont systemFontOfSize:labelFont_size_one];
    _faceAmt.textAlignment = NSTextAlignmentRight;
    [_faceAmt setTextColor:[UIColor redColor]];
    [_faceAmt setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_faceAmt];
    
    //
    _countTitle = [[UILabel alloc]init];
    _countTitle.font = [UIFont systemFontOfSize:labelFont_size_one];
    [_countTitle setTextColor:[UIColor blackColor]];
    [_countTitle setBackgroundColor:[UIColor clearColor]];
    _countTitle.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_countTitle];
    
    [_countTitle setText:@"张数:"];
    maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    titleSize = [_countTitle.text sizeWithFont:_countTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_countTitle setFrame:CGRectMake(self.frame.size.width/2+15, _faceAmtTitel.frame.origin.y+_faceAmtTitel.frame.size.height+10, titleSize.width, titleSize.height)];
    
    _countValue = [[UILabel alloc]init];
    _countValue.font = [UIFont systemFontOfSize:labelFont_size_one];
    _countValue.textAlignment = NSTextAlignmentRight;
    [_countValue setTextColor:[UIColor redColor]];
    [_countValue setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_countValue];
    
    _cardImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, self.frame.size.width/2-30, [TAllscoOrderBuyerCell heightForCell]-10)];
    [self.contentView addSubview:_cardImageView];
    
    return self;
}

- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm {
    [_cardImageView setImageWithURL:[NSURL URLWithString:goodsForm.allscoImageUrl]];
    
    [_faceAmt setText:[NSString stringWithFormat:@"￥%i",[goodsForm.sellPrice intValue]]];
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    CGSize titleSize = [_faceAmt.text sizeWithFont:_faceAmt.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_faceAmt setFrame:CGRectMake(_faceAmtTitel.frame.origin.x+_faceAmtTitel.frame.size.width+10, _faceAmtTitel.frame.origin.y, titleSize.width, titleSize.height)];
    
    [_countValue setText:[NSString stringWithFormat:@"%i",goodsForm.sellNumber]];
    maximumLabelSize = CGSizeMake(self.frame.size.width/2-30, 999);
    titleSize = [_countValue.text sizeWithFont:_countValue.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_countValue setFrame:CGRectMake(_countTitle.frame.origin.x+_countTitle.frame.size.width+10, _faceAmtTitel.frame.origin.y+_faceAmtTitel.frame.size.height+10, titleSize.width, titleSize.height)];
    
    
    
}

+(float)heightForCell {
    return 90;
}

@end
