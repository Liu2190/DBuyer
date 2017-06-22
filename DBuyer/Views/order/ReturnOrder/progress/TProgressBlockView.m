//
//  TProgressBlockView.m
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TProgressBlockView.h"
#import "TUtilities.h"

#define block_w     220

#define block_topAndDown_h 6

#define block_text_font     14

#define block_arrow_w       10
#define block_arrow_h       15


@implementation TProgressBlockView

- (id)initWithPoint:(CGPoint)point andProgressBlock:(TProgressBlock*)block{
    self = [super init];
    float y = 0;
    
    float block_point_size = 6;
    NSString *mark = @"D";
    if (block.execute == 1) {
        mark = @"";
        block_point_size = 15;
    };
    
    // top
    NSString *imageName = [NSString stringWithFormat:@"ReturnOrder_Progress_%@Top.png",mark];
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, block_w-0.7, block_topAndDown_h)];
    [topImageView setImage:[UIImage imageNamed:imageName]];
    [self addSubview:topImageView];
    y += topImageView.frame.size.height;
    
    // box
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    textLabel.numberOfLines = 0;
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont systemFontOfSize:block_text_font]];
    NSString *progressTxt = [[TUtilities getInstance]toConvertStauts:block.status];
    [textLabel setText:progressTxt];
    CGSize maximumLabelSize = CGSizeMake(block_w-10, 999);
    CGSize titleSize = [textLabel.text sizeWithFont:textLabel.font constrainedToSize:maximumLabelSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    
    imageName = [NSString stringWithFormat:@"ReturnOrder_Progress_%@Box.png",mark];
    UIImageView *textBlockView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, block_w, titleSize.height+10)];
    [textBlockView setImage:[UIImage imageNamed:imageName]];
    [textLabel setFrame:CGRectMake(5, 5, titleSize.width, titleSize.height)];
    [self addSubview:textBlockView];
    [textBlockView addSubview:textLabel];
    y += textBlockView.frame.size.height-1;
    
    // bottom
    imageName = [NSString stringWithFormat:@"ReturnOrder_Progress_%@Down.png",mark];
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, block_w-0.8, block_topAndDown_h)];
    [bottomView setImage:[UIImage imageNamed:imageName]];
    [self addSubview:bottomView];
    
    [self setFrame:CGRectMake(point.x, point.y, block_w, bottomView.frame.origin.y+bottomView.frame.size.height)];
    
    // arrow
    imageName = [NSString stringWithFormat:@"ReturnOrder_Progress_%@Arrow.png",mark];
    float center = self.frame.size.height/2;
    CGRect rect = CGRectMake(-block_arrow_w+2, center-block_arrow_h/2, block_arrow_w, block_arrow_h);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    [imageView setImage:[UIImage imageNamed:imageName]];
    [self addSubview:imageView];
    
    
    // add point
    imageName = [NSString stringWithFormat:@"ReturnOrder_Progress_%@Point.png",mark];
    CGRect pointRect = CGRectMake(-30, center-block_point_size/2+1, block_point_size, block_point_size);
    UIImageView *pointImageView = [[UIImageView alloc]initWithFrame:pointRect];
    [pointImageView setImage:[UIImage imageNamed:imageName]];
    [self addSubview:pointImageView];
    
    _pointRect = pointRect;
    
    return self;
}

- (CGRect)getPointRect {
    return _pointRect;
}

@end
