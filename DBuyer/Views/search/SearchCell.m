//
//  SearchCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-5-14.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellValueWith:(NSDictionary *)dict
{
    self.nameLabel.text = [dict objectForKey:@"keyWord"];
    if([[dict objectForKey:@"count"] intValue]!=0)
    {
         self.countLabel.text = [NSString stringWithFormat:@"约%@条",[dict objectForKey:@"count"]];
    }
}
- (void)dealloc {
    [_countLabel release];
    [_nameLabel release];
    [super dealloc];
}
@end
