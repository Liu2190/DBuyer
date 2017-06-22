//
//  TConfirmPayOrderView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-2.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TConfirmPayOrderView.h"

#define left_margin_lenght  10
#define top_margin_lenght   10

#define label_text_font     15

#define hadDoImage_width    20
#define hadDoImage_height   18

#define orderNumber_Area_Height     50
#define orderNumImage_width         15
#define orderNumImage_height        20

@implementation TConfirmPayOrderView


- (id)initWithFrame:(CGRect)frame andConfirmPay:(TConfirmPay*)confirmPay {
    self = [super initWithFrame:frame];
    _confirmPay = confirmPay;
    
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
    [self setBackgroundColor:[UIColor whiteColor]];
    
    float x = left_margin_lenght;
    float y = top_margin_lenght;
    
    UIImageView *hadDoImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, hadDoImage_width, hadDoImage_height)];
    [hadDoImage setImage:[UIImage imageNamed:@"ConfirmPay_HadDo.png"]];
    [self addSubview:hadDoImage];
    
    UILabel *textContentLabel = [[UILabel alloc]init];
    textContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textContentLabel.numberOfLines = 0;
    [textContentLabel setBackgroundColor:[UIColor clearColor]];
    [textContentLabel setFont:[UIFont systemFontOfSize:label_text_font]];
    [textContentLabel setTextColor:[UIColor colorWithRed:16.0/255.0 green:109.0/255.0 blue:90.0/255.0 alpha:1.0]];
    [textContentLabel setText:@"您的订单已经提交,请您尽快付款,付款完成后我们会尽快为您发货!"];
    CGSize maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght-hadDoImage.frame.size.width-10, 999);
    CGSize titleSize = [textContentLabel.text sizeWithFont:textContentLabel.font constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    [textContentLabel setFrame:CGRectMake(left_margin_lenght+hadDoImage.frame.size.width+10, y, titleSize.width, titleSize.height)];
    [self addSubview:textContentLabel];
    
    
    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.lineBreakMode = NSLineBreakByWordWrapping;
    promptLabel.numberOfLines = 0;
    [promptLabel setBackgroundColor:[UIColor clearColor]];
    [promptLabel setFont:[UIFont systemFontOfSize:label_text_font-2]];
    [promptLabel setTextColor:[UIColor grayColor]];
    [promptLabel setText:@"如果您两小时内尚未支付,订单会自动取消!"];
    maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght-hadDoImage.frame.size.width-10, 999);
    titleSize = [promptLabel.text sizeWithFont:promptLabel.font constrainedToSize:maximumLabelSize
                                             lineBreakMode:NSLineBreakByWordWrapping];
    [promptLabel setFrame:CGRectMake(textContentLabel.frame.origin.x, textContentLabel.frame.origin.y+textContentLabel.frame.size.height+10, titleSize.width, titleSize.height)];
    [self addSubview:promptLabel];
    
    
    UIImageView *lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, promptLabel.frame.size.height+promptLabel.frame.origin.y+10, frame.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [self addSubview:lineView];
    
    UILabel *paidAmountLabel = [[UILabel alloc]init];
    paidAmountLabel.lineBreakMode = NSLineBreakByWordWrapping;
    paidAmountLabel.numberOfLines = 0;
    [paidAmountLabel setBackgroundColor:[UIColor clearColor]];
    [paidAmountLabel setFont:[UIFont systemFontOfSize:label_text_font]];
    [paidAmountLabel setTextColor:[UIColor blackColor]];
    NSString *money = _confirmPay.paidAmount;
    
    [paidAmountLabel setText:[NSString stringWithFormat:@"应付金额:   %.2f(元)",[money floatValue]]];
    maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght-hadDoImage.frame.size.width-10, 999);
    titleSize = [paidAmountLabel.text sizeWithFont:paidAmountLabel.font constrainedToSize:maximumLabelSize
                                 lineBreakMode:NSLineBreakByWordWrapping];
    [paidAmountLabel setFrame:CGRectMake(left_margin_lenght, lineView.frame.origin.y+lineView.frame.size.height+10, titleSize.width, titleSize.height)];
    [self addSubview:paidAmountLabel];
    
    UILabel *giveInteiveLabel = [[UILabel alloc]init];
    giveInteiveLabel.lineBreakMode = NSLineBreakByWordWrapping;
    giveInteiveLabel.numberOfLines = 0;
    [giveInteiveLabel setBackgroundColor:[UIColor clearColor]];
    [giveInteiveLabel setFont:[UIFont systemFontOfSize:label_text_font]];
    [giveInteiveLabel setTextColor:[UIColor blackColor]];
    NSString *integral = _confirmPay.integral;
    
    [giveInteiveLabel setText:[NSString stringWithFormat:@"赠送积分:   %@",integral]];
    maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght-hadDoImage.frame.size.width-10, 999);
    titleSize = [giveInteiveLabel.text sizeWithFont:giveInteiveLabel.font constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByWordWrapping];
    [giveInteiveLabel setFrame:CGRectMake(left_margin_lenght, paidAmountLabel.frame.origin.y+paidAmountLabel.frame.size.height+10, titleSize.width, titleSize.height)];
    [self addSubview:giveInteiveLabel];
    
    UILabel *otherLabel = [[UILabel alloc]init];
    otherLabel.lineBreakMode = NSLineBreakByWordWrapping;
    otherLabel.numberOfLines = 0;
    [otherLabel setBackgroundColor:[UIColor clearColor]];
    [otherLabel setFont:[UIFont systemFontOfSize:label_text_font-2]];
    [otherLabel setTextColor:[UIColor grayColor]];
    // 125积分可抵扣1元货款(不含运费)。
    [otherLabel setText:@"积分使用规则稍后推出,敬请期待。"];
    maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght, 999);
    titleSize = [otherLabel.text sizeWithFont:otherLabel.font constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByWordWrapping];
    [otherLabel setFrame:CGRectMake(left_margin_lenght, giveInteiveLabel.frame.origin.y+giveInteiveLabel.frame.size.height+10, titleSize.width, titleSize.height)];
    [self addSubview:otherLabel];
    
    lineView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, otherLabel.frame.size.height+otherLabel.frame.origin.y+10, frame.size.width, 1)]autorelease];
    [lineView setBackgroundColor:[UIColor colorWithRed:163.0/255.0 green:198.0/255.0 blue:191.0/255.0 alpha:1]];
    [self addSubview:lineView];
    float H = lineView.frame.size.height + lineView.frame.origin.y;
    
    float h = orderNumber_Area_Height;
    NSArray *orderList = [_confirmPay.orderIdList componentsSeparatedByString:@","];
    if (orderList.count*25 > h) h = orderList.count*25;
        
    UIView *orderNumAreaView = [[UIView alloc]initWithFrame:CGRectMake(0, H+10, self.frame.size.width-2*left_margin_lenght, h)];
    [self addSubview:orderNumAreaView];
    
    UIImageView *orderNumImage = [[UIImageView alloc]initWithFrame:CGRectMake(left_margin_lenght, 0, orderNumImage_width, orderNumImage_height)];
    [orderNumImage setImage:[UIImage imageNamed:@"ConfirmPay_OrderFlag.png"]];
    [orderNumAreaView addSubview:orderNumImage];
     H = orderNumAreaView.frame.size.height + orderNumAreaView.frame.origin.y;
    
    UILabel *orderTextLabel = [[UILabel alloc]init];
    orderTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    orderTextLabel.numberOfLines = 0;
    [orderTextLabel setBackgroundColor:[UIColor clearColor]];
    [orderTextLabel setFont:[UIFont systemFontOfSize:label_text_font-2]];
    [orderTextLabel setTextColor:[UIColor colorWithRed:115.0/255.0 green:115.0/255.0 blue:115.0/255.0 alpha:1.0]];
    [orderTextLabel setText:@"订单号:"];
    maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght, 999);
    titleSize = [orderTextLabel.text sizeWithFont:orderTextLabel.font constrainedToSize:maximumLabelSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = CGRectMake(orderNumImage.frame.origin.x+orderNumImage.frame.size.width+5, 2, titleSize.width, titleSize.height);
    [orderTextLabel setFrame:rect];
    [orderNumAreaView addSubview:orderTextLabel];
    
    // 算出每一个order number 的高度
    float orderNum_H = (orderNumAreaView.frame.size.height-15)/orderList.count;
    for (int i =0; i<orderList.count; i++) {
        UILabel *orderNumberLabel = [[UILabel alloc]init];
        NSString *orderNumber = [orderList objectAtIndex:i];
        [orderNumberLabel setText:orderNumber];
        orderNumberLabel.lineBreakMode = NSLineBreakByWordWrapping;
        orderNumberLabel.numberOfLines = 0;
        [orderNumberLabel setBackgroundColor:[UIColor clearColor]];
        [orderNumberLabel setFont:[UIFont systemFontOfSize:label_text_font-2]];
        [orderNumberLabel setTextColor:[UIColor colorWithRed:240.0/255.0 green:189.0/255.0 blue:64.0/255.0 alpha:1.0]];
        maximumLabelSize = CGSizeMake(frame.size.width-2*left_margin_lenght, 999);
        titleSize = [orderNumberLabel.text sizeWithFont:orderNumberLabel.font constrainedToSize:maximumLabelSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
        [orderNumberLabel setFrame:CGRectMake(left_margin_lenght, i*orderNum_H+(orderNum_H-titleSize.height)/2+20, titleSize.width, titleSize.height)];
        [orderNumAreaView addSubview:orderNumberLabel];
    }
    H = orderNumAreaView.frame.origin.y + orderNumAreaView.frame.size.height;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, H+15)];
    
    return self;
}



- (CGFloat)heightForView {
    return self.frame.size.height;
}

- (void)dealloc {
    [super dealloc];

}

@end
