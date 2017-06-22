//
//  UPOMP.h
//  UnionPaySDK
//  银联支付插件接口类
//  Created by 翟 尧 on 13-3-27.
//  Copyright (c) 2013年 翟 尧. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    ServerTest = 0,//测试服务器
    ServerProduct = 1//生产服务器
}ServerType;

@protocol UPOMPDelegate <NSObject>

/*
 关闭插件回调方法，由商户客户端实现。
 参数:1.xmlString 交易结束时传递的参数
 返回:无
 */
- (void)closeUPOMPWithXMLString:(NSString *)xmlString;

@end


@interface UPOMP : UINavigationController

@property (nonatomic, assign) id<UPOMPDelegate> UPOMPDelegate;


/*
 初始化方法。
 参数:1.xmlString 商户传递的参数报文 2.ServerType 区分生产、测试环境 ServerProduct生产环境 ServerTest测试环境
 返回:id UPOMP实例
 */
- (id)initUPOMPWithXML:(NSString *)xmlString ServerType:(ServerType)serverType;

@end
