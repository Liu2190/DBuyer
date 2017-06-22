//
//  TAllscoChargeElement.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoChargeElement.h"
#import "TChargeTableCell.h"

@implementation TAllscoChargeElement

- (id)initwithCard:(TAllScoCard*)card {
    self = [super init];
    _card = card;
    self.selectIndex = 0;
    
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    // [tableView setSeparatorInset:UIEdgeInsetsZero];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_charge"];
    
    cell = [[TChargeTableCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 88) andCard:_card andSelectIndex:_selectIndex];
    
    ((TChargeTableCell*)cell).userInteractionEnabled = YES;
    [((TChargeTableCell*)cell) addTargetForButton:controller];
    ((TChargeTableCell*)cell).accessoryType = UITableViewCellAccessoryNone;
    ((TChargeTableCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return _height > 0 ? _height : 88;
}

@end
