//
//  SettlementModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementModel.h"
#import "Product.h"
@implementation SettlementModel

-(id)init
{
    self = [super init];
    if(self)
    {
        _zitiAreaItem = [[SqliteMarketObject alloc]init];
        _freight = 0.0f;
        _useIntegral = 0;
        _addressItem = [[AddressItem alloc]init];
        _allIntegral = 0;
        _totalPrice = 0.0f;
        _productlistArray = [[NSMutableArray alloc]init];
        _buyType = 0;
        _logisticsStatus = YES;
        _isHaveAddress = YES;
        _beginTime = [[NSString alloc]init];
        _endTime = [[NSString alloc]init];
        _destorTime = [[NSString alloc]init];
        _networkStatus = 0;
        _exDateHourArray = [[NSArray alloc]initWithObjects:@"11:00-13:00",@"13:00-15:00",@"15:00-17:00",@"17:00-19:00",@"19:00-21:00",nil];
        _exDateDayArray = [[NSArray alloc]init];
        _takeBySelfTime = [[NSMutableString alloc]init];
        _countOfFirst = 5;
        _orderDeadTime = 0;
        _timeOnTheButton = [[NSMutableString alloc]init];
        _isWuliuHidden = NO;
        _isZitiHidden = YES;
        _productIds = [[NSString alloc]init];
        _zitiDict = [[NSMutableDictionary alloc]init];
        _gid = [[NSString alloc]init];
        _productIdsAndCounts = [[NSString alloc]init];
        _reducePrice = 0;
    }
    return self;
}
-(void)getDefaultSuperMarketArea:(NSDictionary *)dict
{
    NSDictionary *item = [[dict objectForKey:@"storeList"] lastObject];
    NSDictionary *item1 = [[dict objectForKey:@"List"] lastObject];
    self.zitiAreaItem.marketName = [item objectForKey:@"name"];
    self.zitiAreaItem.marketAddress = [item objectForKey:@"address"];
    self.zitiAreaItem.storeSort = [[item1 objectForKey:@"attributeType"] boolValue];
    self.zitiAreaItem.marketId = [item1 objectForKey:@"attributeValue"];
}
-(void)getDefaultAddress:(NSDictionary *)dict
{
    NSInteger states =[[dict objectForKey:@"status"] intValue];
    if(states==0)
    {
        self.isHaveAddress = YES;
        NSArray * array = [dict objectForKey:@"result"];
        for (NSDictionary * item in array)
        {
            AddressItem * tempAddress = [[AddressItem alloc]initWithDic:item];
            // 如果是默认地址则设为当前的地址
            if (tempAddress.isDefault == 1)
            {
                self.addressItem = tempAddress;
            }
        }
    }
    if(states == 3)
    {
        //此时没有默认地址，需要用户输入地址
        self.isHaveAddress = NO;
    }

}
-(void)setZitiDictValueWith:(NSString *)beginTime And:(NSString *)destorTime
{
    NSString *startTime = [beginTime substringToIndex:([beginTime length]-3)];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[startTime integerValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableString *str1=[NSMutableString stringWithString:[formatter stringFromDate:localeDate]];
    [array addObject:str1];
    for(int i=1;i <= 2;i++){
        NSDate *date1=[NSDate dateWithTimeInterval:86400*i sinceDate:localeDate];
        NSMutableString *str2=[NSMutableString stringWithString:[formatter stringFromDate:date1]];
        [array addObject:str2];
    }
    [self.zitiDict setObject:array forKey:@"Component"];//选择器的左侧时间数据
    
    self.orderDeadTime=(int)[destorTime intValue]/1000/60/60;
    self.countOfFirst = [self datepickerRowOfHourComponent];
    NSMutableArray *firstRow = [[NSMutableArray alloc]init];
    for(int i = 5-self.countOfFirst;i<5;i++)
    {
        [firstRow addObject:[self.exDateHourArray objectAtIndex:i]];
    }
    NSMutableArray *secRow = [[NSMutableArray alloc]initWithArray:self.exDateHourArray];
    NSMutableArray *thiRow = [[NSMutableArray alloc]initWithArray:self.exDateHourArray];
    NSArray *rowArray = [NSArray arrayWithObjects:firstRow,secRow,thiRow, nil];
    [self.zitiDict setObject:rowArray forKey:@"Row"];
}
-(void)getFreightAndZitiTime:(NSDictionary *)dict
{
    if([[dict objectForKey:@"status"] intValue] == 0)
    {
        self.freight = [[dict objectForKey:@"zfreight"] floatValue];
        [self setZitiDictValueWith:[[dict objectForKey:@"beginTime"] stringValue] And:[[dict objectForKey:@"destorTime"] stringValue]];
//        NSString * time = [[[dict objectForKey:@"beginTime"] stringValue] substringToIndex:([[[dict objectForKey:@"beginTime"] stringValue] length]-3)];
//        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
//        NSTimeZone *zone = [NSTimeZone systemTimeZone];
//        NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
//        NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
//        self.orderDeadTime=(int)[[dict objectForKey:@"destorTime"] intValue]/1000/60/60;
//        self.countOfFirst = [self datepickerRowOfHourComponent];
//        self.exDateDayArray = [self getDayArrayWith:localeDate];//获取当前日期；
        NSMutableString *tempString = [NSMutableString stringWithFormat:@"%@ %@",[[self.zitiDict objectForKey:@"Component"] objectAtIndex:0],[[[self.zitiDict objectForKey:@"Row"] objectAtIndex:0] objectAtIndex:0]];
        self.takeBySelfTime = tempString;
        self.timeOnTheButton = self.takeBySelfTime;
    }
}
-(void)getIntegral:(NSDictionary *)dict
{
    if([[dict objectForKey:@"status"] intValue] == 0)
    {
        self.allIntegral = [[[[dict objectForKey:@"userInfor"] objectAtIndex:0] valueForKey:@"integral"] integerValue];
    }
}
-(NSString *)AccessTime //获取当前时间
{
    NSDateFormatter *formatter =[[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = [NSDate date];
    [formatter setDateFormat:@"HH"];
    NSMutableString *strr = [NSMutableString stringWithString:[formatter stringFromDate:date]];
    return strr;
}
#pragma mark -  获取自提时间选择栏的左侧日期数据
-(NSMutableArray *)getDayArrayWith:(NSDate *)dateFromNet{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableString *str1=[NSMutableString stringWithString:[formatter stringFromDate:dateFromNet]];
    [array addObject:str1];
    for(int i=1;i <= 2;i++){
        NSDate *date1=[NSDate dateWithTimeInterval:86400*i sinceDate:dateFromNet];
        NSMutableString *str2=[NSMutableString stringWithString:[formatter stringFromDate:date1]];
        [array addObject:str2];
    }
    return array;
}
-(BOOL)whetherArrayNeeded:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        if([item isKindOfClass:[NSArray class]])
        {
            return YES;
        }
    }
    return NO;
}
-(BOOL)isStringNotEmpty:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
-(void)getDeliveryWay:(NSDictionary *)dict
{
    if([[dict objectForKey:@"msg"] intValue]==0)
    {
        //如果有数据返回的情况下
        if([self whetherArrayNeeded:[dict objectForKey:@"deliverList"]]==YES)
        {
            BOOL wuliu = YES;
            for(NSDictionary *item in [dict objectForKey:@"deliverList"])
            {
                
               if([self isStringNotEmpty:[item objectForKey:@"deliveryMethod"]])
               {
                   if([[item objectForKey:@"deliveryMethod"] isEqualToString:@"物流"])
                   {
                       if([self isStringNotEmpty:[item objectForKey:@"usable"]])
                       {
                           if([[item objectForKey:@"usable"] isEqualToString:@"false"])
                        {
                            
                            self.logisticsStatus = NO;
                            self.isWuliuHidden = YES;
                            wuliu = self.logisticsStatus;
                        }
                       }
                   }
                   else if([[item objectForKey:@"deliveryMethod"] isEqualToString:@"自提"])
                   {
                       if([self isStringNotEmpty:[item objectForKey:@"usable"]])
                       {
                           if([[item objectForKey:@"usable"] isEqualToString:@"false"])
                           {
                               self.logisticsStatus = YES;
                               self.isZitiHidden = YES;
                           }
                           else if([[item objectForKey:@"usable"] isEqualToString:@"true"])
                           {
                               self.isZitiHidden = NO;
                               self.logisticsStatus = wuliu;
                           }
                       }
                   }
               }
           }
        }
    }
}

-(NSInteger)datepickerRowOfHourComponent{//当天时间返回第一天的栏数
    
    int hour;
    
    hour = [[self AccessTime] intValue] + self.orderDeadTime + 3;
    
    if(hour >= 0 && hour < 13){
        return 5;
    }
    else if(hour >= 13 && hour < 15){
        return 4;
    }
    else if(hour >= 15 && hour < 17){
        return 3;
    }
    else if(hour >= 17 && hour < 19){
        return 2;
    }
    else if(hour >= 19 && hour < 21){
        return 1;
    }
    return 5;
}
-(void)setModelWithProducts:(NSMutableArray *)productArr SeettType:(int )SettType GiftID:(NSString *)giftId Price:(float)price
{
    self.gid = giftId;
    self.setType = SettType;
    if(giftId !=0)
    {
        self.totalPrice = price;
    }
    else
    {
        CGFloat priceCount = 0.00;
        for (Product *produc in productArr) {
            priceCount += produc.sellPrice * produc.count;
        }
        self.totalPrice = priceCount;
    }
    [self.productlistArray removeAllObjects];
    [self.productlistArray addObjectsFromArray:productArr];
    NSMutableDictionary *productIdDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableArray *productIdArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (Product *product in self.productlistArray) {
        [productIdDic setValue:[NSString stringWithFormat:@"%d", product.count] forKey:product.productID];
        [productIdArray addObject:product.productID];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:productIdDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * proIdsArray = [productIdArray componentsJoinedByString:@","]; // 使用逗号分割数组封装为订单ID字符串
    NSString *proIdsDic = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:proIdsArray, proIdsDic, nil] forKeys:[NSArray arrayWithObjects:@"proIdsArray", @"proIdsDic", nil]];
    self.productIdsAndCounts = [result objectForKey:@"proIdsDic"];
    self.productIds = [result objectForKey:@"proIdsArray"];
}
@end
