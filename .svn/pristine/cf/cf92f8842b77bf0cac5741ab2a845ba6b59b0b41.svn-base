//
//  supermarketCell.m
//  DBuyer
//
//  Created by simman on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SupermarketCell.h"

@interface SupermarketCell() {
    id _viewController;
    SEL _selector;
}

@end

@implementation SupermarketCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


#pragma mark - 按钮点击事件
- (IBAction)SupermarketAction:(id)sender {
    [_viewController performSelector:_selector withObject:sender];
}


#pragma mark - 回调
- (void)addTarget:(id)target Action:(SEL)action
{
    _viewController = target;
    _selector = action;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_SuperMarketButton release];
    [super dealloc];
}
@end
