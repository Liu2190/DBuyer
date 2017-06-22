//
//  OrderTraceCell.m
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderTraceCell.h"
#import "Trace.h"

@implementation OrderTraceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setOrderTraceCellWithTrace:(Trace *)trace isFirst:(BOOL)isFirst
{
    if (trace.execute == 1) {
        self.backgroundImage.image = [UIImage imageNamed:@"order_trace_01"];
    } else {
        self.backgroundImage.image = [UIImage imageNamed:@"order_trace_02"];
    }
    self.traceNameLable.text = trace.status_name;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_traceNameLable release];
    [_backgroundImage release];
    [super dealloc];
}
@end
