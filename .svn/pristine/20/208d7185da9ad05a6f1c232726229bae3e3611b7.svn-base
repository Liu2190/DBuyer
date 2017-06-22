//
//  TAllscoGoodCell.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoGoodCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extra.h"

#define font_size         15
#define other_font_size   12

#define image_width 110

#define btn_width_size  80

#define space       10

@implementation TAllscoGoodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    float H = [TAllscoGoodCell heightForCell];
    float h = H - 2*space;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(space, space, image_width, h)];
    [self.contentView addSubview:_imageView];
    
    _titleDesc = [[UILabel alloc]init];
    _titleDesc.lineBreakMode = NSLineBreakByWordWrapping;
    _titleDesc.numberOfLines = 0;
    [_titleDesc setBackgroundColor:[UIColor clearColor]];
    [_titleDesc setFont:[UIFont systemFontOfSize:font_size]];
    [_titleDesc setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_titleDesc];
    
    _allscoDesc = [[UILabel alloc]init];
    _allscoDesc.lineBreakMode = NSLineBreakByTruncatingTail;
    _allscoDesc.numberOfLines = 2;
    [_allscoDesc setBackgroundColor:[UIColor clearColor]];
    [_allscoDesc setFont:[UIFont systemFontOfSize:other_font_size-2]];
    [_allscoDesc setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:_allscoDesc];
    
    _cardCost = [[UILabel alloc]init];
    _cardCost.lineBreakMode = NSLineBreakByWordWrapping;
    _cardCost.numberOfLines = 0;
    [_cardCost setBackgroundColor:[UIColor clearColor]];
    [_cardCost setFont:[UIFont systemFontOfSize:other_font_size]];
    [_cardCost setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_cardCost];
    
    
    _sellPrice = [[UILabel alloc]init];
    _sellPrice.lineBreakMode = NSLineBreakByWordWrapping;
    _sellPrice.numberOfLines = 0;
    [_sellPrice setBackgroundColor:[UIColor clearColor]];
    [_sellPrice setFont:[UIFont systemFontOfSize:other_font_size]];
    [_sellPrice setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_sellPrice];
    
    blockView = [[TAllscoGoodBlock alloc]init];
    [self.contentView addSubview:blockView];
    
    CGRect rect = CGRectMake(0, [TAllscoGoodCell heightForCell]-.8, self.frame.size.width, .8);
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:rect];
    [lineImageView setImage:[UIImage imageNamed:@"AllScoGood_ListLine.png"]];
    [self.contentView addSubview:lineImageView];
    
    return self;
}

+ (float)heightForCell {
    return 100;
}

- (void)setDataForCell:(TAllscoGoodsForm*)goodsForm andTarget:(id)target andIndex:(int)index {
    NSURL *url = [NSURL URLWithString:goodsForm.allscoImageUrl];
    [_imageView setImageWithURL:url];
    
    //
    float x = _imageView.frame.origin.x+_imageView.frame.size.width+15;
    [_titleDesc setText:goodsForm.allscoTitle];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_titleDesc.text sizeWithFont:_titleDesc.font constrainedToSize:maximumLabelSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    [_titleDesc setFrame:CGRectMake(x, space-2, titleSize.width, titleSize.height)];

    [_allscoDesc setText:goodsForm.allscodesc];
    CGSize maximumLabelSize_ = CGSizeMake(self.frame.size.width/2+15, 3*other_font_size);
    titleSize = [_allscoDesc.text sizeWithFont:_allscoDesc.font constrainedToSize:maximumLabelSize_
                                       lineBreakMode:NSLineBreakByTruncatingTail];
    [_allscoDesc setFrame:CGRectMake(x, _titleDesc.frame.size.height+_titleDesc.frame.origin.y, titleSize.width, titleSize.height)];
    
    //
    [_cardCost setText:[NSString stringWithFormat:@"面值：￥%@",goodsForm.cardCost]];
    titleSize = [_cardCost.text sizeWithFont:_cardCost.font constrainedToSize:maximumLabelSize
                                       lineBreakMode:NSLineBreakByWordWrapping];
    [_cardCost setFrame:CGRectMake(x, [TAllscoGoodCell heightForCell]-space-2*titleSize.height, titleSize.width, titleSize.height)];
    
    //
    [_sellPrice setText:[NSString stringWithFormat:@"售价：￥%@",goodsForm.sellPrice]];
    [_sellPrice setTextColor:[UIColor orangeColor]];
    titleSize = [_sellPrice.text sizeWithFont:_sellPrice.font constrainedToSize:maximumLabelSize
                               lineBreakMode:NSLineBreakByWordWrapping];
    [_sellPrice setFrame:CGRectMake(x, [TAllscoGoodCell heightForCell]-space-titleSize.height, titleSize.width, titleSize.height)];
    
    [blockView setFrame:CGRectMake(_cardCost.frame.origin.x+_cardCost.frame.size.width+10, _cardCost.frame.origin.y+3, self.frame.size.width-(_cardCost.frame.origin.x+_cardCost.frame.size.width+10)-space, [TAllscoGoodCell heightForCell]-_cardCost.frame.origin.y-space-3)];
    [blockView addActinForTarget:target andIndex:index];
}

- (BOOL)addOrderNum {
    return [blockView addOrderNum];
}

- (BOOL)reduceOrderNum {
    return [blockView reduceOrderNum];
}

- (void)dealloc {
    [super dealloc];
    
    [_imageView release];
    _imageView = nil;
    
    [_titleDesc release];
    _titleDesc = nil;
    
    [_cardCost release];
    _cardCost = nil;
    
    [_sellPrice release];
    _sellPrice = nil;
}

@end
