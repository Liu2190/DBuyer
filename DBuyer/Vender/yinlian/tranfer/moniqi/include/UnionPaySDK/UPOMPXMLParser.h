//
//  UPOMPXMLParser.h
//  UnionPaySDK
//  UPOMP解析商户传递订单参数类
//  Created by 翟尧 on 12-10-15.
//  Copyright (c) 2012年 翟尧. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UPOMPXMLParser : NSObject <NSXMLParserDelegate>{
    NSXMLParser *_parser;
    NSString *_rspStr;
    NSMutableString *_messStr;
    NSMutableDictionary *_infoDic;
}

/*
 解析插件回传的交易参数
 参数:1.sendData 交易结束时传递的参数
 返回:NSMutableDictionary 参数字典
 */
-(NSMutableDictionary *)parserXML:(NSData *)sendData;

@end
