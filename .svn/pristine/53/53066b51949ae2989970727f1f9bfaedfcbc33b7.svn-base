//
//  TPasswordMenuView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPasswordMenuView.h"

#define pass_step_num   3
#define textLabel_size  14

@implementation TPasswordMenuView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    float w = frame.size.width/pass_step_num;
    float h = frame.size.height;
    
    NSArray *stepText = @[@"输入手机号",@"输入验证码",@"重置密码"];
    NSArray *imageNames = @[@"password_onestep_bg.png",@"password_twostep_bg.png",@"password_threeStep_bg.png"];
    
    for (int i=0; i<pass_step_num; i++) {
        UIView *findpass_view = [[UIView alloc]initWithFrame:CGRectMake(i*w, 0, w, h)];
        [findpass_view setBackgroundColor:[UIColor clearColor]];
        [self addSubview:findpass_view];
        
        UILabel *textLabel = [[UILabel alloc]init];
        [textLabel setText:[stepText objectAtIndex:i]];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setFont:[UIFont boldSystemFontOfSize:textLabel_size]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        CGSize titleSize = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];

        float x = (findpass_view.frame.size.width-titleSize.width)/2;
        float y = (findpass_view.frame.size.height-titleSize.height)/2;
        [textLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
        [findpass_view addSubview:textLabel];
    
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
        NSString *imageName = [imageNames objectAtIndex:i];
        [imageView setImage:[UIImage imageNamed:imageName]];
        [findpass_view addSubview:imageView];
        if (i != 0) imageView.hidden = YES;
        
        if (i == 0) {
            arrowImageView_0 = [[UIImageView alloc]init];
            [arrowImageView_0 setFrame:CGRectMake(w-12, 0, 13, h)];
            [arrowImageView_0 setImage:[UIImage imageNamed:@"password_arrow.png"]];
            [findpass_view addSubview:arrowImageView_0];
        }
        
        if (i == 1) {
            arrowImageView_1 = [[UIImageView alloc]init];
            [arrowImageView_1 setFrame:CGRectMake(w-12, 0, 13, h)];
            [arrowImageView_1 setImage:[UIImage imageNamed:@"password_arrow.png"]];
            [findpass_view addSubview:arrowImageView_1];
        }
        
    }
    
    return self;
}

- (void) goPageByindex:(int)index {
    if (index == 1) {
        arrowImageView_0.hidden = YES;
        arrowImageView_1.hidden = NO;
    }
    if (index == 2) {
        arrowImageView_0.hidden = NO;
        arrowImageView_1.hidden = YES;
    }
    
    for (int i=0;i<self.subviews.count;i++) {
        UIView *view = [self.subviews objectAtIndex:i];
        UIImageView *bgView =  [view.subviews objectAtIndex:1];
        if (i != index) bgView.hidden = YES;
        else bgView.hidden = NO;
    }
}



@end
