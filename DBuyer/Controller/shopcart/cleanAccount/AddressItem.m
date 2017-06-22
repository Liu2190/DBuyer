//
//  AddressItem.m
//  DBuyer
//  地址元素类
//  Created by lixinda on 13-11-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "AddressItem.h"

@implementation AddressItem
- (id)init
{
    self = [super init];
    if (self) {
        _addressId = [[NSString alloc]init];
        _name = [[NSString alloc]init];
        _address = [[NSString alloc]init];
        _phoneNumber = [[NSString alloc]init];
        _boutique = [[NSString alloc]init];
        _boutiqueAdd = [[NSString alloc]init];
        _isDefault = 0;
        _stores = [[NSString alloc]init];
        _storesAdd = [[NSString alloc]init];
        _areaId = [[NSString alloc]init];
        _areaName = [[NSString alloc]init];
    }
    return self;
}
-(id) initWithDic:(NSDictionary *) dic{
    AddressItem * addressItem = [[AddressItem alloc]init];
    
    addressItem.phoneNumber = [dic objectForKey:@"contact"];
    //取得地址
    addressItem.address = [dic objectForKey:@"address"];
    //取得收件人
    addressItem.name = [dic objectForKey:@"consignee"];
    addressItem.addressId =[dic objectForKey:@"ID"];
    
    addressItem.boutique = [dic objectForKey:@"boutique"];
    addressItem.boutiqueAdd = [dic objectForKey:@"boutiqueAdd"];
    
    NSString * tempStr =[dic objectForKey:@"isDefault"];
    addressItem.isDefault = tempStr.integerValue;
    addressItem.stores = [dic objectForKey:@"stores"];
    addressItem.storesAdd = [dic objectForKey:@"storesAdd"];
    
    addressItem.areaId = [dic objectForKey:@"areaId"];
    addressItem.areaName = [dic objectForKey:@"name"];
    return  addressItem;
}
-(NSMutableDictionary * ) returnDic{
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.phoneNumber forKey:@"contact"];
    [dict setObject:self.address forKey:@"address"];
    [dict setObject:self.name forKey:@"consignee"];
    [dict setObject:self.addressId forKey:@"ID"];
    [dict setObject:self.boutique forKey:@"boutique"];
    [dict setObject:self.boutiqueAdd forKey:@"boutiqueAdd"];
    [dict setObject:[NSString stringWithFormat:@"%d",self.isDefault] forKey:@"isDefault"];
    [dict setObject:self.stores forKey:@"stores"];
    [dict setObject:self.storesAdd forKey:@"storesAdd"];
    [dict setObject:self.areaId forKey:@"areaId"];
    [dict setObject:self.areaName forKey:@"areaName"];
    
    return dict;
}
-(NSString *) returnAreaId{
    //组成areaId的字符串   地址id
    NSString * result = nil;
    result = [NSString stringWithFormat:@"%@",/*self.name,self.phoneNumber,self.address,*/self.addressId];
    return result;
}
-(NSString *)returnAreaAdd{
    //姓名&电话&地址信息&
    NSString * result = nil;
    result = [NSString stringWithFormat:@"%@dbuyer@%@dbuyer@%@",self.name,self.phoneNumber,self.address];
    return result;

}
@end
