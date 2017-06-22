//
//  RecommendScrollView.m
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "RecommendScrollView.h"
#import "BtnDelegate.h"
#import "shangpin.h"
#import "Product.h"
#import "GiftRightView.h"
#import "GiftCell.h"

@interface RecommendScrollView ()

@property (nonatomic, assign) UIScrollView * thisScrol;

@end

@implementation RecommendScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGFloat)heightOfRecommendView
{
    if (_haveTitle) {
        return Height1;
    } else {
        return Height2;
    }
}

- (id)initWithArray:(NSArray *)productArray startPoint:(CGPoint)point
{
    return [self initWithArray:productArray title:nil startPoint:point];
}

-(id)initWithArray:(NSArray *)productArray title:(NSString *)title startPoint:(CGPoint)point
{
    CGFloat height = 0;
    if (title != nil) {
        _haveTitle = YES;
        height = Height1;
    } else {
        height = Height2;
    }
    
    CGRect frame = CGRectMake(point.x, point.y, 320, height);
    [super initWithFrame:frame];
    [self initWithFrame:frame];
    
    self.thisScrol = [[[UIScrollView alloc] init] autorelease];
    if (title != nil) { // 如果显示标题
        UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)] autorelease];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
        titleLabel.backgroundColor=[UIColor clearColor];
        [self addSubview:titleLabel];
        
        UIImageView * lineImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, 1)] autorelease];
        lineImage.image = [UIImage imageNamed:@"Image_RecommendCell_03"];
        [self addSubview:lineImage];
        
        self.thisScrol.frame = CGRectMake(0, 30, frame.size.width, frame.size.height - 30);
    } else {
        self.thisScrol.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    
    self.thisScrol.delegate=self;
    self.thisScrol.scrollEnabled=YES;
    [self addSubview:self.thisScrol];
    self.userInteractionEnabled=YES;
    self.thisScrol.userInteractionEnabled=YES;
    self.thisScrol.showsHorizontalScrollIndicator = NO;
    self.thisScrol.showsVerticalScrollIndicator = NO;
    
    // 如果传入数组装得对象是商品类型
    if ([productArray count] < 1) {
        return self;
    }
    if ([productArray[0] isMemberOfClass:[Product class]]) {
        self.thisScrol.contentSize=CGSizeMake(100*[productArray count], 125);
        for(int i=0; i<[productArray count]; i++) {
            shangpin *productView=[shangpin shangPin];
            CGRect frame = productView.frame;
            frame.origin.x += i * 100 + 15;
            productView.frame = frame;
            
            productView.tag = i;
            UITapGestureRecognizer * tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedView:)] autorelease];
            [productView addGestureRecognizer:tap];
            [productView showWithProduct:[productArray objectAtIndex:i]];
            [self.thisScrol addSubview:productView];
        }

    } else { // 是礼包
        self.thisScrol.contentSize=CGSizeMake(320*[productArray count], 125);
        // 显示礼包
        for(int i=0; i<[productArray count]; i++) {
            GiftRightView * giftView = [[[NSBundle mainBundle] loadNibNamed:@"GiftRightView" owner:nil options:nil] lastObject];
            CGRect frame = giftView.frame;
            frame.origin.y += 0;
            frame.origin.x += i * 320;
            giftView.frame = frame;
            giftView.tag = i;
            UITapGestureRecognizer * tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedView:)] autorelease];
            [giftView addGestureRecognizer:tap];
            GiftCell * gift = productArray[i];
            giftView.giftSavePrice.text=[NSString stringWithFormat:@"￥%.2f",gift.savePrice];
            giftView.giftName.text= gift.title;
            [giftView.giftImage setImageWithURL:[NSURL URLWithString:gift.boxPicUrl]];
            giftView.gitfPrice.text = [NSString stringWithFormat:@"%.2f",gift.price];
            
            [self.thisScrol addSubview:giftView];
        }
    }
    return self;
}

- (void)showWithProducts:(NSArray *)productArray
{
    // 首先移除所有视图
    for (UIView * view in self.thisScrol.subviews) {
        [view removeFromSuperview];
    }
    if (productArray.count < 1) {
        return;
    }
    // 如果传入数组装得对象是商品类型
    if ([productArray[0] isMemberOfClass:[Product class]]) {
        self.thisScrol.contentSize=CGSizeMake(100*[productArray count], 125);
        
        for(int i=0; i<[productArray count]; i++) {
            shangpin *productView=[shangpin shangPin];
            CGRect frame = productView.frame;
            frame.origin.x += i * 100 + 15;
            productView.frame = frame;
            
            productView.tag = i;
            UITapGestureRecognizer * tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedView:)] autorelease];
            [productView addGestureRecognizer:tap];
            [productView showWithProduct:[productArray objectAtIndex:i]];
            [self.thisScrol addSubview:productView];
        }
        
    } else { // 是礼包
        self.thisScrol.contentSize=CGSizeMake(320*[productArray count], 125);
        // 显示礼包
        for(int i=0; i<[productArray count]; i++) {
            GiftRightView * giftView = [[[NSBundle mainBundle] loadNibNamed:@"GiftRightView" owner:nil options:nil] lastObject];
            CGRect frame = giftView.frame;
            frame.origin.y += 0;
            frame.origin.x += i * 320;
            giftView.frame = frame;
            giftView.tag = i;
            UITapGestureRecognizer * tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedView:)] autorelease];
            [giftView addGestureRecognizer:tap];
            GiftCell * gift = productArray[i];
            giftView.giftSavePrice.text=[NSString stringWithFormat:@"￥%.2f",(gift.savePrice - gift.price)];
            giftView.giftName.text= gift.title;
            [giftView.giftImage setImageWithURL:[NSURL URLWithString:gift.boxPicUrl]];
            giftView.gitfPrice.text = [NSString stringWithFormat:@"%.2f",gift.price];
            giftView.giftDescription.text=gift.boxDescription;
            [self.thisScrol addSubview:giftView];
        }
    }
}

-(void)didClickedView:(UITapGestureRecognizer *)sender
{
    NSInteger index = sender.view.tag;
    if (self.RSdelegate && [self.RSdelegate respondsToSelector:@selector(RecommendViewDidClicked:)]) {
        [self.RSdelegate RecommendViewDidClicked:index];
    }
}
@end
