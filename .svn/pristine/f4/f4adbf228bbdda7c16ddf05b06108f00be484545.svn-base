//
//  TReturnOrderListController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderListController.h"
#import "TReturnOrderDetailController.h"
#import "TLoginController.h"
#import "TServerFactory.h"
#import "TOrderServer.h"
#import "TMasCnpServer.h"
#import "TReturnOrderCell.h"
#import "TUtilities.h"
#import "TOrder.h"
#import "TGoods.h"
#import "DbuyerActive.h"
#import "TReturnOrderProgressController.h"
#import "TReturnOrderDetailController_.h"

#define image_size_w    150
#define image_size_h    150

@implementation TReturnOrderListController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1.0]];
    
    [self getReturnOrderList];
}

- (void)getReturnOrderList {
    [[TUtilities getInstance]popTarget:self.contentView];
    [[TServerFactory getServerInstance:@"TOrderServer"]getReturnOrderListByCallback:^(NSArray *datas) {
        [[TUtilities getInstance]dismiss];
        
        for (TOrder *order in datas) [self.datas addObject:order];
        [self.tableView reloadData];
        
        if (self.datas.count==0) {
            [self doViewEmptyOrder];
            UIAlertView * al = [[ UIAlertView alloc ]initWithTitle:@"提示" message:@"没有退款的订单" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil ];
            [ al show ];
            return;
        }
        
    } failureCallback:^(NSString *resp) {
        [[TUtilities getInstance]popMessageError:resp target:self.contentView delayTime:1.0];
        
    }];
    
}

/**
 * 空处理界面
 */
- (void)doViewEmptyOrder {
    // order_null
    UIImage *image = [UIImage imageNamed:@"order_null.png"];
    UIImageView *imageView = [[[UIImageView alloc]initWithImage:image]autorelease];
    CGSize imageViewSize = image.size;
    [imageView setFrame:CGRectMake((self.tableView.frame.size.width-imageViewSize.width)/2, 100, imageViewSize.width, imageViewSize.height)];
    [self.tableView addSubview:imageView];
    
    UILabel *descLabel = [[[UILabel alloc]init]autorelease];
    [descLabel setBackgroundColor:[UIColor clearColor]];
    [descLabel setText:@"暂无退款订单"];
    [descLabel setFont:[UIFont systemFontOfSize:14]];
    [descLabel setTextColor:[UIColor whiteColor]];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [descLabel.text sizeWithFont:descLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    float x = (self.tableView.frame.size.width-titleSize.width)/2;
    float y = imageView.frame.origin.y+imageView.frame.size.height+30;
    [descLabel setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    [self.tableView addSubview:descLabel];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.datas.count>0?self.datas.count:0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"TReturnOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    
    if (cell == nil) {
        cell = [[TReturnOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    id data = [self.datas objectAtIndex:indexPath.row];
    [((TReturnOrderCell*)cell) setDataForCell:data andIndex:indexPath.row];
    [((TReturnOrderCell*)cell) setTargetAction:self];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TOrder *order = [self.datas objectAtIndex:indexPath.row];
    /*TReturnOrderDetailController *returnOrderDetailController = [[TReturnOrderDetailController alloc]initWithNavigationTitle:@"退款订单详情"];
    [self.navigationController pushViewController:returnOrderDetailController animated:YES];
    returnOrderDetailController.order = order;
    [returnOrderDetailController release];*/

    TReturnOrderDetailController_ *orderDetailVC = [[TReturnOrderDetailController_ alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    [orderDetailVC addTarget:self Action:@selector(doProgressAction:)];
    orderDetailVC.orderId = order.serverId;
    orderDetailVC.orderDetailType = WaitBuyerPayOrderDetail;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}

- (void)doProgressAction:(id)sender {
    UIButton *btn = (UIButton*)sender;
    int index = btn.tag;
    TOrder *order = [self.datas objectAtIndex:index];
    
    TReturnOrderProgressController *returnOrderProgressController = [[TReturnOrderProgressController alloc]initWithNavigationTitle:@"退款订单进度"];
    returnOrderProgressController.order = order;
    [self.navigationController pushViewController:returnOrderProgressController animated:YES];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if( [alertView.message isEqualToString:@"没有退款的订单"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
