
//
//  Trace.m
//  DBuyer
//
//  Created by simman on 14-1-17.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "Trace.h"
@implementation Trace

- (id)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        _status = [dic objectForKey:@"status"];
        _createDate = [[dic objectForKey:@"createDate"] integerValue];
        _execute = [[dic objectForKey:@"execute"] integerValue];
        _orderId = [dic objectForKey:@"orderId"];
        _traceType = [[dic objectForKey:@"traceType"] integerValue];
//        NSArray *array=[NSArray arrayWithObjects:
//                        @"您提交了订单",
//                        @"您的订单商品正在备货",
//                        @"您的订单商品备货完毕",
//                        @"您的订单商品打包完毕",
//                        @"货品已经发出，请您准备收货",
//                        @"您的订单正在配送",
//                        @"已完成配送，欢迎再次光临！",nil];
        // 如果是物流
        if (_traceType == 0) {
            switch ([_status integerValue]) {
                case 2:
                    _status_name = @"您的订单正在确认";
                    break;
                case 3:
                    _status_name = @"您的订单正在备货";
                    break;
                case 4:
                    _status_name = @"您的订单已完成备货，正在配送";
                    break;
                case 7:
                    _status_name = @"已完成配送，欢迎再次光临";
                    break;
                default:
                    _status_name = @"";
                    break;
            }
        // 如果是自提
        } else if (_traceType == 1) {
            switch ([_status integerValue]) {
                case 2:
                    _status_name = @"您的订单正在确认";
                    break;
                case 3:
                    _status_name = @"您的订单正在备货";
                    break;
                case 4:
                    _status_name = @"您的订单已完成备货，等待提货";
                    break;
                case 7:
                    _status_name = @"已完成提货，欢迎再次光临";
                    break;
                default:
                    _status_name = @"";
                    break;
            }
        } else {
            //----
        }
    }
    return self;
}

@end
