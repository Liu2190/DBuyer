//
//  CollectEditCell.m
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CollectEditCell.h"
#import "Product.h"

@interface CollectEditCell ()

@property (nonatomic, assign) id target;
@property (nonatomic) SEL deleteAction;
@property (nonatomic) SEL joinPlanAction;

@end

@implementation CollectEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (id)collectEditCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CollectEditCell" owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (void)addtarget:(id)target deleteAction:(SEL)action joinPlanAction:(SEL)joinPlanAction
{
    self.target = target;
    self.deleteAction = action;
    self.joinPlanAction = joinPlanAction;
}
- (void)showWithProduct:(Product *)product
{
    // 商品图片
    [self.productImageView setImageWithURL:[NSURL URLWithString:product.attrValue]];
    // 显示商品名
    CGRect frame = self.productNameLabel.frame;
    frame.size.width = 195;
    self.productNameLabel.frame = frame;// CGRectMake(118, 14, 185, 38);
    
    self.productNameLabel.text = product.commodityName;
    self.productNameLabel.numberOfLines = 2;
    //    [self.productNameLabel sizeToFit];
    // 价格
    self.productPriceLabel.text = [NSString stringWithFormat:@"%.2f", product.sellPrice];
}

+ (float)heightOfCell
{
    return 100;
}
- (void)dealloc {
    [_productImageView release];
    [_productNameLabel release];
    [_productPriceLabel release];
    [_joinPlanButton release];
    [super dealloc];
}
- (IBAction)deleteButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.deleteAction withObject:self];
}

- (IBAction)joinPlanButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.joinPlanAction withObject:self];
}
@end
