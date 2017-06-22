//
//  TAllscoGoodListController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoGoodListController.h"
#import "TAllscoBuyerController.h"
#import "TAllscoGoodCell.h"
#import "TAllscoGoodsForm.h"
#import "TUtilities.h"
#import "TServerFactory.h"
#import "TAllScoServer.h"


#define toolbar_height  50

@implementation TAllscoGoodListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.allowsSelection = NO;
    
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]doGetAllscoCardGoodsByCallback:^(NSArray *datas) {
        [[TUtilities getInstance]dismiss];
        if (datas.count > 0) {
            for (TAllscoGoodsForm *goodForm in datas) {
                [self.datas addObject:goodForm];
            }
            
            [self.tableView reloadData];
        }
        
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.0];
    }];
    
    _toolBar = [[TAllscoGoodBuyerToolBar alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-toolbar_height, self.contentView.frame.size.width, toolbar_height)];
    [_toolBar addActionForTarget:self];
    [self.contentView addSubview:_toolBar];
}

- (void)addTableView {
    float w = self.contentView.frame.size.width;
    float h = self.contentView.frame.size.height-toolbar_height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.contentView addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName=@"AllscoGoodListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[TAllscoGoodCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    TAllscoGoodsForm *goodsForm = [self.datas objectAtIndex:indexPath.row];
    [((TAllscoGoodCell*)cell) setDataForCell:goodsForm andTarget:self andIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TAllscoGoodCell heightForCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count>0?self.datas.count:0;
}


- (void)doBuyerBtnAction:(id)sender {
    NSArray *goodItems = [self getGoodItemForBuyer];
    
    TAllscoBuyerController *buyerController = [[TAllscoBuyerController alloc]initWithNavigationTitle:@"结算中心" andGoodsForm:goodItems];
    [self.navigationController pushViewController:buyerController animated:YES];
}


- (NSArray*)getGoodItemForBuyer {
    NSMutableArray *buyerItems = [[[NSMutableArray alloc]init]autorelease];
    
    for(TAllscoGoodsForm *goodForm in self.datas) {
        if (goodForm.sellNumber > 0)
            [buyerItems addObject:goodForm];
    }
    
    return buyerItems;
}

- (int)getTotalMoneySize {
    int totalMoney = 0;
    
    for(TAllscoGoodsForm *goodForm in self.datas) {
        if (goodForm.sellNumber > 0) {
            int sellPrice = [goodForm.sellPrice intValue];
            totalMoney += goodForm.sellNumber*sellPrice;
        }
    }
    
    return totalMoney;
}

/**
 * 为预付卡商品订单添加数量
 */
- (void)doPlusAction:(id)send {
    UIButton *btn = (UIButton*)send;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    TAllscoGoodCell *tableCell = (TAllscoGoodCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    TAllscoGoodsForm *goodForm = [self.datas objectAtIndex:btn.tag];
    if (goodForm.sellNumber == 5) {
        [[TUtilities getInstance]popMessageError:@"张数不能大于5" target:self.tableView delayTime:2.0f];
        return;
    }
    
    [tableCell addOrderNum];
    goodForm.sellNumber += 1;
    [_toolBar setMoneySize:[self getTotalMoneySize]];
}

/**
 * 为预付卡商品订单递减数量
 */
- (void)doReduceAction:(id)send {
    UIButton *btn = (UIButton*)send;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    TAllscoGoodCell *tableCell = (TAllscoGoodCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    BOOL boolean = [tableCell reduceOrderNum];
    
    TAllscoGoodsForm *goodForm = [self.datas objectAtIndex:btn.tag];
    if (!boolean){
        [[TUtilities getInstance]popMessageError:@"张数不能小于0" target:self.tableView delayTime:2.0f];
        return;
    }
    
    goodForm.sellNumber -= 1;
    [_toolBar setMoneySize:[self getTotalMoneySize]];
}

@end
