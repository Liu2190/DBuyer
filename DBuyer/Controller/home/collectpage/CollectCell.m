//
//  CollectCell.m
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CollectCell.h"
#import "Product.h"

@implementation CollectCell

+ (id)collectCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"CollectCell" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)showWithProduct:(Product *)product {
    // 商品图片
    [self.productImageView setImageWithURL:[NSURL URLWithString:product.attrValue] placeholderImage:[UIImage imageNamed:@"placeHolerImage80"]];
    // 显示商品名
    CGRect frame = self.productNameLabel.frame;
    frame.size.width = 195;
    self.productNameLabel.frame = frame;
    self.productNameLabel.text = product.commodityName;
    self.productNameLabel.numberOfLines = 2;
    self.productPriceLabel.text = [NSString stringWithFormat:@"%.2f", product.sellPrice];
    if(product.sellPrice <= product.marketPrice ||product.marketPrice == 0.0 )
    {
        //如果现价小于或者等于原价，不显示原价
        self.productRefPriceNameLabel.hidden = YES;
        self.deleteLineLabel.hidden = YES;
    }
    else
    {
        self.productRefPriceNameLabel.hidden = NO;
        self.deleteLineLabel.hidden = NO;
        self.productRefPriceNameLabel.text = [NSString stringWithFormat:@"参考价￥%.2f", product.marketPrice];
    }
    if(!(product.productDescription==nil||product.productDescription ==NULL) &&(![product.productDescription isKindOfClass:[NSNull class]]))
       {
           if([product.productDescription length]!=0)
           {
               self.productDescripLabel.text = product.productDescription;
           }
       }
     /*   self.productDealLabel.frame = CGRectMake(96, 72, 60, 21);
        self.productPriceLabel.frame = CGRectMake(139, 71, 80, 21);
        self.productRefPriceNameLabel.frame = CGRectMake(205,72,100,21);
        self.deleteLineLabel.frame = CGRectMake(203, 63, 108, 21);*/
   /* else
    {
        CGRect frame = self.productDealLabel.frame;
        frame.origin.y = frame.origin.y - 5;
        self.productDealLabel.frame = frame;
        frame = self.productPriceLabel.frame;
        frame.origin.y = frame.origin.y - 5;
        self.productPriceLabel.frame = frame;
        frame = self.productRefPriceNameLabel.frame;
        frame.origin.y = frame.origin.y - 5;
        self.productRefPriceNameLabel.frame = frame;
        frame = self.deleteLineLabel.frame;
        frame.origin.y = frame.origin.y - 5;
        self.deleteLineLabel.frame = frame;
    }*/
    // 供应商列表
    [self setProductKeyWord:product.keyWord];
}

// 设置显示商品keyWord
- (void)setProductKeyWord:(NSString *)keyWord
{
    if (self.productKeyWordImageView1 != nil) {
        [self.productKeyWordImageView1 removeFromSuperview];
    }
    if (self.productKeyWordImageView2 != nil) {
        [self.productKeyWordImageView2 removeFromSuperview];
    }
    if (self.productKeyWordImageView3 != nil) {
        [self.productKeyWordImageView3 removeFromSuperview];
    }
    if (self.productKeyWordLabel1 != nil) {
        [self.productKeyWordLabel1 removeFromSuperview];
    }
    if (self.productKeyWordLabel2 != nil) {
        [self.productKeyWordLabel2 removeFromSuperview];
    }
    if (self.productKeyWordLabel3 != nil) {
        [self.productKeyWordLabel3 removeFromSuperview];
    }
    
    NSArray *tempArray = [keyWord componentsSeparatedByString:@","];//用来放置标签
    NSMutableArray * labelArray = [NSMutableArray array];
    // 去空格
    for (NSString * str in tempArray) {
        NSString * resultStr = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (![resultStr isEqualToString:@""]) {
            [labelArray addObject:resultStr];
        }
    }
    
    CGRect frame0 = CGRectMake(95, 93, 55, 21);
    if (labelArray.count > 0) {
        NSString * str0 = labelArray[0];
        if (str0.length >= 3) {
            frame0.size.width = frame0.size.width * 0.25 * str0.length;
        } else {
            frame0.size.width = frame0.size.width * 0.25 * 3;
        }
        
        self.productKeyWordImageView1.frame = frame0;
        self.productKeyWordImageView1 = [[[UIImageView alloc] initWithFrame:frame0] autorelease];
        
        self.productKeyWordImageView1.contentMode = UIViewContentModeScaleToFill;
        self.productKeyWordImageView1.image = [UIImage imageNamed:@"Image_Collect_01"];
        [self.contentView addSubview:self.productKeyWordImageView1];
        
        frame0.origin.x += 4;
        self.productKeyWordLabel1 = [[[UILabel alloc] initWithFrame:frame0] autorelease];
        self.productKeyWordLabel1.text = [NSString stringWithFormat:@"%@", labelArray[0]];
        self.productKeyWordLabel1.textColor = [UIColor whiteColor];
        self.productKeyWordLabel1.backgroundColor=[UIColor clearColor];
        self.productKeyWordLabel1.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.productKeyWordLabel1];
    }
    
    CGRect frame1 = CGRectMake(95, 93, 55, 21);
    if (labelArray.count > 1) {
        NSString * str1 = labelArray[1];
        frame1.origin.x = frame0.origin.x + frame0.size.width + 5;
        if (str1.length >= 3) {
            frame1.size.width = frame1.size.width * 0.25 * str1.length;
        } else {
            frame1.size.width = frame1.size.width * 0.25 * 3;
        }
        
        self.productKeyWordImageView2.frame = frame1;
        self.productKeyWordImageView2 = [[[UIImageView alloc] initWithFrame:frame1] autorelease];
        
        self.productKeyWordImageView2.contentMode = UIViewContentModeScaleToFill;
        self.productKeyWordImageView2.image = [UIImage imageNamed:@"Image_Collect_01"];
        [self.contentView addSubview:self.productKeyWordImageView2];
        
        frame1.origin.x += 4;
        self.productKeyWordLabel2 = [[[UILabel alloc] initWithFrame:frame1] autorelease];
        self.productKeyWordLabel2.text = [NSString stringWithFormat:@"%@", str1];
        self.productKeyWordLabel2.textColor = [UIColor whiteColor];
        self.productKeyWordLabel2.backgroundColor=[UIColor clearColor];
        self.productKeyWordLabel2.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.productKeyWordLabel2];
    }
    CGRect frame2 = CGRectMake(95, 93, 55, 21);
    if (labelArray.count > 2) {
        NSString * str2 = labelArray[2];
        frame2.origin.x = frame1.origin.x + frame1.size.width + 5;
        if (str2.length >= 3) {
            frame2.size.width = frame2.size.width * 0.25 * str2.length;
        } else {
            frame2.size.width = frame2.size.width * 0.25 * 3;
        }
        
        self.productKeyWordImageView3.frame = frame2;
        self.productKeyWordImageView3 = [[[UIImageView alloc] initWithFrame:frame2] autorelease];
        
        self.productKeyWordImageView3.contentMode = UIViewContentModeScaleToFill;
        self.productKeyWordImageView3.image = [UIImage imageNamed:@"Image_Collect_01"];
        [self.contentView addSubview:self.productKeyWordImageView3];
        
        frame2.origin.x += 4;
        self.productKeyWordLabel3 = [[[UILabel alloc] initWithFrame:frame2] autorelease];
        self.productKeyWordLabel3.text = [NSString stringWithFormat:@"%@", str2];
        self.productKeyWordLabel3.textColor = [UIColor whiteColor];
        self.productKeyWordLabel3.backgroundColor=[UIColor clearColor];
        self.productKeyWordLabel3.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.productKeyWordLabel3];
    }
}
+ (float)heightOfCell
{
    return 120;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_productImageView release];
    [_productNameLabel release];
    [_productPriceLabel release];
    [_deleteLineLabel release];
    [_productKeyWordLabel1 release];
    [_productKeyWordLabel2 release];
    [_productKeyWordImageView1 release];
    [_productKeyWordImageView2 release];
    [_productKeyWordImageView3 release];
    [_productKeyWordLabel3 release];
    [_productRefPriceNameLabel release];
    [_productDescripLabel release];
    [_productDealLabel release];
    [super dealloc];
}
@end
