//
//  TUserHadLoginFace.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserHadLoginFace.h"
#import "UIButton+Extensions.h"

#define arrow_size_w   10
#define arrow_size_h   15

#define btn_size_w   100
#define btn_size_h   25

@implementation TUserHadLoginFace

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _accountLabel = [[[UILabel alloc]init]autorelease];
    _accountLabel.font = [UIFont systemFontOfSize:16];
    [_accountLabel setBackgroundColor:[UIColor clearColor]];
    [_accountLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_accountLabel];
    
    _jfLabel = [[[UILabel alloc]init]autorelease];
    _jfLabel.font = [UIFont systemFontOfSize:16];
    [_jfLabel setBackgroundColor:[UIColor clearColor]];
    [_jfLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_jfLabel];
    
    _jfBtn = [[UIButton alloc]init];
    [self addSubview:_jfBtn];
    
    _arrowImageView = [[UIImageView alloc]init];
    _arrowImageView.image = [UIImage imageNamed:@"UserCenter_Arrow.png"];
    [self addSubview:_arrowImageView];
    
    _faceImageView = [[UIImageView alloc]init];
    _faceImageView.image = [UIImage imageNamed:@"UserCenter_Logo.png"];
    [_faceImageView setFrame:CGRectMake(0, (frame.size.height-40)/2, 40, 40)];
    _faceImageView.clipsToBounds = YES;
    _faceImageView.layer.cornerRadius = _faceImageView.frame.size.width/2;
    [self addSubview:_faceImageView];
    
    return self;
}

- (void) setViewData:(NSString*)account andJf:(int)jfValue {
    NSString *aa = [account stringByReplacingCharactersInRange:NSMakeRange (3, 4) withString:@"****"];
    _accountLabel.text = aa;
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_accountLabel.text sizeWithFont:_accountLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_accountLabel setFrame:CGRectMake((self.frame.size.width-titleSize.width)/2, 25, titleSize.width, titleSize.height)];
    
    _jfLabel.text = [NSString stringWithFormat:@"可用积分%i",jfValue];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [_jfLabel.text sizeWithFont:_jfLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    [_jfLabel setFrame:CGRectMake(_accountLabel.frame.origin.x, self.frame.size.height-45, titleSize.width, titleSize.height)];
    
    [_arrowImageView setFrame:CGRectMake(_jfLabel.frame.origin.x+_jfLabel.frame.size.width+10, self.frame.size.height-43, arrow_size_w, arrow_size_h)];
    
    [_jfBtn setFrame:CGRectMake(_accountLabel.frame.origin.x, self.frame.size.height-45, btn_size_w, btn_size_h)];
    
}

- (void)setTargetForButton:(id)target {
    [_jfBtn addTarget:target action:@selector(clickJFButton:) forControlEvents:UIControlEventTouchUpInside];
    [_jfBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -30)];
}


- (void)dealloc {
    [super dealloc];
    [_jfBtn release];
    _jfBtn = nil;
    
    [_jfLabel release];
    _jfLabel = nil;
    
    [_accountLabel release];
    _accountLabel = nil;
    
    [_arrowImageView release];
    _arrowImageView = nil;
    
    [_faceImageView release];
    _faceImageView = nil;
}

@end
