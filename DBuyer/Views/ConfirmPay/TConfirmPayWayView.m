//
//  TConfirmPayWayView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TConfirmPayWayView.h"
#import "TPayWayBlockView.h"

#define block_view_height   70

@implementation TConfirmPayWayView
/*
- (id)initWithFrame:(CGRect)frame andPayways:(NSArray*)payways {
    self = [super initWithFrame:frame];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, payways.count*block_view_height)];
    [self setBackgroundColor:[UIColor clearColor]];
    self.payways = [[NSMutableArray alloc]init];
    
    for (int i=0; i<payways.count; i++) {
        NSNumber *theNumber = [payways objectAtIndex:i];
        PayWayType paytype = [theNumber intValue];
        
        NSString *logoImageName;
        NSString *logoDescName;
        if (paytype == PayWay_UM) {
            logoImageName = @"ConfirmPay_UM_Logo.png";
            logoDescName = @"(银联支付)";
        }
        
        if (paytype == PayWay_KQ) {
            logoImageName = @"ConfirmPay_KQ_Logo.png";
            logoDescName = @"(快钱支付)";
        }
        
        
        if (paytype == PAyWay_ALLSCO) {
            logoImageName = @"ConfirmPay_Allsco_Logo.png";
            logoDescName = @"(预付卡支付,专享特价优惠)";
        }
        
        
        
        CGRect rect = CGRectMake(0, i*(block_view_height-10)+i*10, frame.size.width,block_view_height-10);
        TPayWayBlockView *blockView = [[TPayWayBlockView alloc]initWithFrame:rect logoImageName:logoImageName andLogoDescName:logoDescName];
        [blockView setTagForBtn:paytype];
        if (paytype == PayWay_UM) [blockView updateBtnImage:YES];
        [blockView setActionForTarget:self];
        [self addSubview:blockView];
    
        [_payways addObject:blockView];
    }
    
    return self;

}*/


 - (id)initWithFrame:(CGRect)frame andPayways:(NSArray*)payways {
     self = [super initWithFrame:frame];
     [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, payways.count*block_view_height)];
     [self setBackgroundColor:[UIColor clearColor]];
     self.payways = [[NSMutableArray alloc]init];
 
     for (int i=0; i<payways.count; i++) {
        NSDictionary *wayDic = [payways objectAtIndex:i];
         PayWayType paytype = [[wayDic objectForKey:@"cardType"]intValue];
         NSString *cardName = [wayDic objectForKey:@"cardName"];
 
         NSString *logoImageName;
         NSString *logoDescName;
         if (paytype == PayWay_UM) {
             logoImageName = @"ConfirmPay_UM_Logo.png";
             logoDescName = cardName;
         }
 
         if (paytype == PayWay_KQ) {
             logoImageName = @"ConfirmPay_KQ_Logo.png";
             logoDescName = cardName;
         }
 
 
         if (paytype == PAyWay_ALLSCO) {
             logoImageName = @"ConfirmPay_Allsco_Logo.png";
             logoDescName = cardName;
         }
 
 
 
         CGRect rect = CGRectMake(0, i*(block_view_height-10)+i*10, frame.size.width,block_view_height-10);
         TPayWayBlockView *blockView = [[TPayWayBlockView alloc]initWithFrame:rect logoImageName:logoImageName andLogoDescName:logoDescName];
         [blockView setTagForBtn:paytype];
         if (paytype == PayWay_UM) [blockView updateBtnImage:YES];
         if (i==0)[blockView updateBtnImage:YES];
         [blockView setActionForTarget:self];
         [self addSubview:blockView];
 
         [_payways addObject:blockView];
     }
 
     return self;
 
 }


/**
 * 选择支付方式复选按钮被点击
 */
- (void)doPayWayClicked:(id)sender {
    UIButton *btn =  (UIButton*)sender;
    if (btn.isSelected) return;
    
    for (TPayWayBlockView *blockView in _payways) {
        if (blockView.getTagForBtn == btn.tag) {
            [blockView updateBtnImage:YES];
        } else {
            [blockView updateBtnImage:NO];
        }
    }
}


- (CGFloat)heightForView {
    return self.frame.size.height;
}

- (int)getPayWay2checkBox {
    int tagValue = 0;
    
    for (int i=0; i<_payways.count; i++) {
        TPayWayBlockView *blockView =  [_payways objectAtIndex:i];
        if(blockView.isSelected2Btn) {
            return [blockView getTagForBtn];
        }
    }
    
    return tagValue;
}

- (void)dealloc {
    [super dealloc];
    [_payways release];
    _payways = nil;
    
}

@end
