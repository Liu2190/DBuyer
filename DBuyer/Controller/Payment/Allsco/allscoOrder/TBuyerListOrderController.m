//
//  TBuyerListOrderController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBuyerListOrderController.h"
#import "TAllscoOrderCell.h"
#import "TAllscoOrderForm.h"
#import "TServerFactory.h"
#import "TAllScoServer.h"
#import "TUtilities.h"
#import "TDbuyerUser.h"

@implementation TBuyerListOrderController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.canLoad = YES;
    
    [[TUtilities getInstance]popTarget:self.tableView status:@"加载中..."];
    [self getDataSource:self.pageNum];
}

- (void)getDataSource:(int)pageNO {
    TDbuyerUser *dbUser = [[TUtilities getInstance]getDbuyerUser];
    [[TServerFactory getServerInstance:@"TAllScoServer"]doGetBuyerAllscoOrderListByAccount:dbUser.name andPageNo:pageNO andPageSize:10 andCallback:^(NSArray *datas) {
        [[TUtilities getInstance]dismiss];
        
        if (datas.count>0) {
            for (TAllscoOrderForm *orderForm in datas)
                [self.datas addObject:orderForm];
            
            [self.tableView reloadData];
        } else {
            self.canLoad = NO;
        }
        
        [self loadMoreCompleted];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.5];
        [self loadMoreCompleted];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName=@"AllscoOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[TAllscoOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    TAllscoOrderForm *goodsForm = [self.datas objectAtIndex:indexPath.row];
    [((TAllscoOrderCell*)cell) setDataForCell:goodsForm];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TAllscoOrderCell heightForCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count>0?self.datas.count:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    TAllscoOrderForm *orderForm = [self.datas objectAtIndex:indexPath.row];
    
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]doGetBuyerCardDetailByAccount:orderForm.phoneNum andOrderNo:orderForm.orderNum andCallback:^(TAllscoOrderForm *orderFormObj) {
        [[TUtilities getInstance]dismiss];
        [self.allscoOrderDelegate pushBuyerDetail:[orderFormObj retain]];
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:1.5];
    }];
}

/**
 * 上拉刷新回调
 */
- (void) addItemsOnBottom {
    self.pageNum += 1;
    if (!self.canLoad) {
        self.canLoadMore = NO;
        [self loadMoreCompleted];
        return;
    }
    
    [self getDataSource:self.pageNum];
}

@end