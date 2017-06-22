//
//  TUserCenterCell.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterCell_0.h"

#define arrow_size_w   10
#define arrow_size_h   15

@implementation TUserCenterCell_0

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _rightArrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-arrow_size_w-10, (self.frame.size.height-arrow_size_h)/2+2, arrow_size_w-4, arrow_size_h-4)];
    [_rightArrowImageView setImage:[UIImage imageNamed:@"arrows_right_1.png"]];
    _rightArrowImageView.hidden = YES;
    [self addSubview:_rightArrowImageView];
    
    return self;
}

- (void)setDataForCell:(TRowModel*)rowModel {
    if (rowModel.isArrow) _rightArrowImageView.hidden = NO;
    
    if (rowModel.isSperator) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        [label setBackgroundColor:[UIColor colorWithRed:167.0/255 green:191.0/255 blue:185.0/255 alpha:1.0]];
        [self addSubview:label];
    }
    
}

- (void)setActionForTarget:(id)target {
    
}

@end
