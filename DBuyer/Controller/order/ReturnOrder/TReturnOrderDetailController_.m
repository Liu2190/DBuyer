//
//  TReturnOrderDetailController_.m
//  DBuyer
//
//  Created by dilei liu on 14-3-20.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TReturnOrderDetailController_.h"

@implementation TReturnOrderDetailController_

-(void)downloadComplete:(HttpDownload *)hd1{
    
    NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd1.downloadData options:NSJSONReadingMutableContainers error:nil];
    
    if(dict){
        [self.mainDelegate endLoad];
        if(hd1.type==1989)
        {
            if([[dict objectForKey:@"status"] intValue]==0){
                [self.leveyTabBarController addNumToCarList:[[dict objectForKey:@"count"] stringValue]];
            }
        }
        if(hd1.type==1200){
            //接收商品详细的信息，并进行跳转
            if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                return;
            }
        }
#pragma mark 订单信息
        if(hd1.type==10097){
            //接收订单信息
            NSInteger states =[[dict objectForKey:@"status"] intValue];
            if(states==0){
                self.paidAmount = [[dict objectForKey:@"paidAmount"] floatValue];
                NSString * max = [dict objectForKey:@"maxPoints"];
                self.maxPoints = max.integerValue;  // 可以用积分
                NSString * temp = [dict objectForKey:@"usejf"];//您本次使用的积分
                self.integral = temp.integerValue;  // 总积分
                
                [self.detailFooterView setOrderDetailFooterViewWithIntegra:[NSString stringWithFormat:@"%ld", (long)self.integral] price:[NSString stringWithFormat:@"%@ 元", temp]];
                [dict setObject:[dict valueForKey:@"orderId"] forKey:@"ID"];
                [self.tableHeaderView.orderNumberLabel setText:[dict valueForKey:@"orderId"]];
                self.order = [[Order alloc] initOrderWithOrderDic:dict];
                NSArray * orderList = [dict objectForKey:@"goodsList"];
                for (NSDictionary * item in orderList) {
                    self.logisticsType = [[item objectForKey:@"logisticsType"] integerValue]; // 运输类型
                    self.transportation=[[item objectForKey:@"transportation"] floatValue];  // 邮费
                    self.buyType=[[item objectForKey:@"buyType"] stringValue];           // 购买类型
                    
                    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",[item objectForKey:@"getDate"]];
                    if([str1 length]>10){
                        NSString *str = [str1 substringWithRange:NSMakeRange(0, 10)];
                        self.getOrderTime = str;
                    }
                    
                    #define TypeOfPackage 8//订单为礼包类型
                    if([self.buyType intValue]==TypeOfPackage){
                        self.amountPayable=[item objectForKey:@"amountPayable"];
                    }
                    //当订单为礼包时，总价不用计算。
                    Product * product = [[Product alloc]initProductWithDic:item];
                    [self.goodsList addObject:product];
                }
                
                // 设置SectionHeadView
                if (self.orderDetailType == DidFinishOrderDetail) { // 完成
                    [self.footerView setDidFinishOrderDetailView];
                } else if (self.orderDetailType == WaitBuyerPayOrderDetail) {  // 等待支付
                    [self.footerView setFooterviewPayTitle:@"查看进度"];
                    [self.footerView addTarget:self checkBoxAction:nil payAction:@selector(GoPayAction:)];
                } else if (self.orderDetailType == WaitConsigneeDetail) {   // 等待收货
                    [self.footerView setFooterviewPayTitle:WaitConsigneeDetailFooterTitle];
                    [self.footerView addTarget:self checkBoxAction:nil payAction:@selector(logisticsTrace:)];
                    [self.footerView setWaitConsigneeDetailView];
                }
                // 获取地址
                // 如果是_logisticsType 自提
                if (self.logisticsType == 1) {
                    NSDictionary *addressItem = [[dict objectForKey:@"shopName"] lastObject];
                    self.addressItem.name = [addressItem objectForKey:@"name"];
                    self.addressItem.storesAdd = [addressItem objectForKey:@"address"];
                    // 是物流
                } else {
                    // .....-----  2014.01.19 $%^UI
                    NSArray *goodsListArr = [dict objectForKey:@"goodsList"];
                    NSString *addressItem = [[goodsListArr objectAtIndex:0] objectForKey:@"areaAdd"];
                    NSArray *addArr = [addressItem componentsSeparatedByString:@"dbuyer@"];
                    
                    if([addArr count]!=0){
                        self.addressItem.name = [addArr objectAtIndex:0];
                        if([addArr count]>1){
                            
                            self.addressItem.phoneNumber = [addArr objectAtIndex:1];
                        }
                        if ([addArr count] == 4) {
                            self.addressItem.storesAdd = [NSString stringWithFormat:@"%@%@", [addArr objectAtIndex:3], [addArr objectAtIndex:2]];
                        } else {
                            if(addArr.count > 2){
                                self.addressItem.storesAdd = [NSString stringWithFormat:@"%@", [addArr objectAtIndex:2]];
                            }
                        }
                    }
                }

                self.networkStatus++;
                [self countTotalPariceWithPoint:0];
                [self.mainDelegate endLoad];
                [self.tableView reloadData];
                
                [self.footerView removeFromSuperview];
            }
        }
    }
}

@end
