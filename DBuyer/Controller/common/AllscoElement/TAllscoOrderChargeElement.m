//
//  TAllscoOrderChargeElement.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderChargeElement.h"
#import "TAllscoOrderChargeCell.h"

@implementation TAllscoOrderChargeElement

- (id)initWithGoodForm:(TAllScoCharge*)chargeForm {
    self = [super init];
    _chargeForm = chargeForm;
    
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_buyer"];
    
    cell = [[TAllscoOrderChargeCell alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
    [((TAllscoOrderChargeCell*)cell) setDataForCell:_chargeForm];
    ((TAllscoOrderChargeCell*)cell).userInteractionEnabled = YES;
    ((TAllscoOrderChargeCell*)cell).accessoryType = UITableViewCellAccessoryNone;
    ((TAllscoOrderChargeCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return [TAllscoOrderChargeCell heightForCell];
}

@end
