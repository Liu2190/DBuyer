//
//  AddressItem.h
//  DBuyer
//  
//  Created by lixinda on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressItem : NSObject
@property (nonatomic,copy) NSString * addressId;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * phoneNumber;
@property (nonatomic,copy) NSString * boutique;     //精品超市ID
@property (nonatomic,copy) NSString * boutiqueAdd;
@property (nonatomic,assign) NSInteger isDefault;
@property (nonatomic,copy) NSString * stores;       //综合超市ID
@property (nonatomic,copy) NSString * storesAdd;
@property (nonatomic,copy) NSString * areaId;
@property (nonatomic,copy) NSString * areaName;

@property (nonatomic,copy) NSString *orderNumber;


-(NSMutableDictionary * ) returnDic;
-(id) initWithDic:(NSDictionary *) dic;

//组成areaId的字符串   姓名&电话&地址信息&地址id
-(NSString *) returnAreaId;
-(NSString *) returnAreaAdd;
@end
