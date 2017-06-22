//
//  TAllscoOrderBuyerElement.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoOrderBuyerElement.h"
#import "TAllscoOrderBuyerCell.h"

@implementation TAllscoOrderBuyerElement

- (id)initWithGoodForm:(TAllscoGoodsForm*)goodForm {
    self = [super init];
    _goodsForm = goodForm;
    
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_buyer"];
    
    cell = [[TAllscoOrderBuyerCell alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
    [((TAllscoOrderBuyerCell*)cell) setDataForCell:_goodsForm];
    ((TAllscoOrderBuyerCell*)cell).userInteractionEnabled = YES;
    ((TAllscoOrderBuyerCell*)cell).accessoryType = UITableViewCellAccessoryNone;
    ((TAllscoOrderBuyerCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return [TAllscoOrderBuyerCell heightForCell];
}

@end
