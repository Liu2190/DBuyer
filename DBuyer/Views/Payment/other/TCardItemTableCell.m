//
//  TCardItemTableCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TCardItemTableCell.h"

#define font_size   12

#define checkBoxBtn_width   25
#define checkBoxBtn_height  25

@implementation TCardItemTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setFrame:CGRectMake(0, 0, 290, 50)];
    _cardNumLabel = [[[UILabel alloc]init]autorelease];
    _cardNumLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _cardNumLabel.numberOfLines = 0;
    [_cardNumLabel setBackgroundColor:[UIColor clearColor]];
    [_cardNumLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_cardNumLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [self addSubview:_cardNumLabel];
    
    _residualMoneyLabel = [[[UILabel alloc]init]autorelease];
    _residualMoneyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _residualMoneyLabel.numberOfLines = 0;
    [_residualMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [_residualMoneyLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_residualMoneyLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [self addSubview:_residualMoneyLabel];
    
    float y = (self.frame.size.height - checkBoxBtn_height)/2;
    _checkBoxBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, y, checkBoxBtn_width, checkBoxBtn_height)];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_unSelected.png"] forState:UIControlStateNormal];
    [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_hadSelected.png"] forState:UIControlStateHighlighted];
    [self addSubview:_checkBoxBtn];
    
    _payMoneyLabel = [[[UILabel alloc]init]autorelease];
    _payMoneyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _payMoneyLabel.numberOfLines = 0;
    [_payMoneyLabel setBackgroundColor:[UIColor clearColor]];
    [_payMoneyLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_payMoneyLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [self addSubview:_payMoneyLabel];
    
    _payResidualLabel = [[[UILabel alloc]init]autorelease];
    _payResidualLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _payResidualLabel.numberOfLines = 0;
    [_payResidualLabel setBackgroundColor:[UIColor clearColor]];
    [_payResidualLabel setFont:[UIFont systemFontOfSize:font_size]];
    [_payResidualLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [self addSubview:_payResidualLabel];
    
    return self;
}

- (void)setDataForCell:(TAllScoCard*)card andHeaderPayInfo:(THeaderPayEnity*)payEnity andIndex:(int)index {
    _checkBoxBtn.tag = index;
    
    if ([card.payAmount floatValue] >0) { // 选择
        [_cardNumLabel setText:card.cardNumber];
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        CGSize titleSize = [_cardNumLabel.text sizeWithFont:_cardNumLabel.font constrainedToSize:maximumLabelSize
                                              lineBreakMode:NSLineBreakByWordWrapping];
        float y = ([TCardItemTableCell heightForCell]/2-titleSize.height)/2;
        [_cardNumLabel setFrame:CGRectMake(50,y, titleSize.width, titleSize.height)];
        
        //
        [_residualMoneyLabel setText:[NSString stringWithFormat:@"可用余额:￥%@",card.residual]];
        maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [_residualMoneyLabel.text sizeWithFont:_residualMoneyLabel.font constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
        y = ([TCardItemTableCell heightForCell]/2-titleSize.height)/2;
        [_residualMoneyLabel setFrame:CGRectMake(self.frame.size.width-titleSize.width-10,y, titleSize.width, titleSize.height)];
        
        //
        [_payMoneyLabel setText:[NSString stringWithFormat:@"支付:￥%@",card.payAmount]];
        maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [_payMoneyLabel.text sizeWithFont:_payMoneyLabel.font constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
        y = ([TCardItemTableCell heightForCell]/2-titleSize.height)/2+[TCardItemTableCell heightForCell]/2;
        
        float x = _cardNumLabel.frame.origin.x+_cardNumLabel.frame.size.width - titleSize.width;
        [_payMoneyLabel setFrame:CGRectMake(x,y, titleSize.width, titleSize.height)];
        
        //
        [_payResidualLabel setText:[NSString stringWithFormat:@"剩余:￥%@",card.payResidual]];
        maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [_payResidualLabel.text sizeWithFont:_payResidualLabel.font constrainedToSize:maximumLabelSize
                                        lineBreakMode:NSLineBreakByWordWrapping];
        y = ([TCardItemTableCell heightForCell]/2-titleSize.height)/2+[TCardItemTableCell heightForCell]/2;
        x = _residualMoneyLabel.frame.origin.x+_residualMoneyLabel.frame.size.width - titleSize.width;
        [_payResidualLabel setFrame:CGRectMake(x,y, titleSize.width, titleSize.height)];
        
        [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_hadSelected.png"] forState:UIControlStateNormal];
        [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_unSelected.png"] forState:UIControlStateHighlighted];
        _checkBoxBtn.enabled = YES;
        [_checkBoxBtn setSelected:YES];
    } else { // 未选择
        [_cardNumLabel setText:card.cardNumber];
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        CGSize titleSize = [_cardNumLabel.text sizeWithFont:_cardNumLabel.font constrainedToSize:maximumLabelSize
                                              lineBreakMode:NSLineBreakByWordWrapping];
        float y = ([TCardItemTableCell heightForCell]-titleSize.height)/2;
        [_cardNumLabel setFrame:CGRectMake(50,y, titleSize.width, titleSize.height)];
        
        [_residualMoneyLabel setText:[NSString stringWithFormat:@"可用余额:￥%@",card.residual]];
        maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [_residualMoneyLabel.text sizeWithFont:_residualMoneyLabel.font constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
        y = ([TCardItemTableCell heightForCell]-titleSize.height)/2;
        [_residualMoneyLabel setFrame:CGRectMake(self.frame.size.width-titleSize.width-10,y, titleSize.width, titleSize.height)];
        
        [_payMoneyLabel setText:@""];
        [_payResidualLabel setText:@""];
        
        
        float needPay = [payEnity.needPayMoney floatValue];
        if (needPay >0) {
            _checkBoxBtn.enabled = YES;
            [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_unSelected.png"] forState:UIControlStateNormal];
            [_checkBoxBtn setImage:[UIImage imageNamed:@"AllScoPay_hadSelected.png"] forState:UIControlStateHighlighted];
        } else {
            _checkBoxBtn.enabled = NO;
            [_checkBoxBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [_checkBoxBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        }
        [_checkBoxBtn setSelected:NO];
        
    }
}

- (void)setTargetForAction:(id)obj {
    [_checkBoxBtn addTarget:obj action:@selector(doClickBoxBtn:) forControlEvents:UIControlEventTouchUpInside];
}



+ (float)heightForCell {
    return 50;
}


@end
