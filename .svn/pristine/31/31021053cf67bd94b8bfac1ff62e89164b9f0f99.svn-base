//
//  TAllscoBuyerElement.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-30.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoBuyerElement.h"
#import "TBuyerTableCell.h"

@implementation TAllscoBuyerElement

- (id)initWithGoodForm:(TAllscoGoodsForm*)goodForm {
    self = [super init];
    _goodsForm = goodForm;
    
    return self;
}

- (UITableViewCell *)getCellForTableView:(QuickDialogTableView *)tableView controller:(QuickDialogController *)controller {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_buyer"];
    
    cell = [[TBuyerTableCell alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 100)];
    [((TBuyerTableCell*)cell) setDataForCell:_goodsForm];
    ((TBuyerTableCell*)cell).userInteractionEnabled = YES;
    ((TBuyerTableCell*)cell).accessoryType = UITableViewCellAccessoryNone;
    ((TBuyerTableCell*)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)getRowHeightForTableView:(QuickDialogTableView *)tableView {
    return [TBuyerTableCell heightForCell];
}



@end
