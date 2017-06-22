//
//  GiftDetail.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "GiftDetail.h"
#import "Product.h"
@implementation GiftDetail
-(id)init
{
    self = [super init];
    if(self)
    {
        _ID = [[NSString alloc]initWithString:@""];
        _attrValue = [[NSString alloc]initWithString:@""];
        _boxComments = [[NSString alloc]initWithString:@""];
        _boxName = [[NSString alloc]initWithString:@""];
        _boxPrice = 0.0f;
        _savePrice = 0.0f;
        _buyArray = [[NSMutableArray alloc]init];
        _sendArray = [[NSMutableArray alloc]init];
        _slideArray = [[NSArray alloc]init];
    }
    return self;
}
/*
 {
 boxList =     (
 {
 ID = 70191b0c95f44a0da181784e1a9d0cbe;
 boxComments = "\U6211\U7684\U6700\U7231";
 boxName = "\U6211\U7684\U6700\U7231";
 boxPrice = "445.6";
 savePrice = "111.4";
 }
 );
 goodsListMai =     (
 {
 attrValue = "http://www.dbuyer.cn/image19/7441001617010L168x1681.JPG";
 category = "<null>";
 goodsID = C61AF40F70900002EC2897F7893019B9;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U53cc\U6995\U6811\U9999\U8349\U725b\U5976250ml";
 packageNumber = 0;
 privce = 40;
 },
 {
 attrValue = "http://www.dbuyer.cn/image19/7441001615009L168x1681.JPG";
 category = "<null>";
 goodsID = C61AF3B8DED000026EAA878415548650;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U53cc\U6995\U6811\U5de7\U514b\U529b\U725b\U5976250ml";
 packageNumber = 0;
 privce = 40;
 },
 {
 attrValue = "http://www.dbuyer.cn/image19/7441001601071L168x1681.JPG";
 category = "<null>";
 goodsID = C61AF2C5C7400002258185B116B0126A;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U53cc\U6995\U6811\U8d85\U9ad8\U6e29\U706d\U83cc\U5168\U8102\U7eaf\U725b\U59761L";
 packageNumber = 0;
 privce = 66;
 },
 {
 attrValue = "http://www.dbuyer.cn/image19/6004944000243L168x1681.JPG";
 category = "<null>";
 goodsID = C61AF27D824000022DE311004A701688;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U745e\U8d1d\U514b\U7a96\U85cf\U7cfb\U5217\U54c1\U4e50\U73e0\U5e72\U7ea2\U8461\U8404\U9152";
 packageNumber = 0;
 privce = 296;
 },
 {
 attrValue = "http://www.dbuyer.cn/image19/6001240200056L168x168.jpg";
 category = "<null>";
 goodsID = C61AF0A946E000025110658041603040;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U897f\U745e\U65af\U9c9c\U6a59\U6df7\U5408\U679c\U6c41200ml";
 packageNumber = 0;
 privce = 30;
 },
 {
 attrValue = "http://www.dbuyer.cn/image19/6001240100257L168x168.JPG";
 category = "<null>";
 goodsID = C61AEC7E4DF000024EAD1B531FCD8A40;
 goodsName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U4ee3\U7406 \U897f\U745e\U65af\U8292\U679c\U9999\U68a8\U6df7\U5408\U679c\U6c411L";
 packageNumber = 0;
 privce = 85;
 }
 );
 goodsListZen =     (
 );
 msg = "\U6709\U76f8\U5e94\U7684\U6570\U636e";
 status = 0;
 }
 */
-(id)initGiftWithDict:(NSDictionary *)dict
{
    [self init];
    if([self whetherDataNeeded:[dict objectForKey:@"boxList"]])
    {
        for(NSDictionary *boxListDict in [dict objectForKey:@"boxList"])
        {
            self.ID = [boxListDict objectForKey:@"ID"];
            self.attrValue = [boxListDict objectForKey:@"attrValue"];
            self.boxComments = [boxListDict objectForKey:@"boxComments"];
            self.boxName = [boxListDict objectForKey:@"boxName"];
            self.boxPrice = [[boxListDict objectForKey:@"boxPrice"] floatValue];
            self.savePrice = [[boxListDict objectForKey:@"savePrice"] floatValue];
            self.slideArray = [[boxListDict objectForKey:@"attrValue"] componentsSeparatedByString:@","];
        }
    }
    if([self whetherDataNeeded:[dict objectForKey:@"goodsListMai"]])
    {
        for(NSDictionary *maiDict in [dict objectForKey:@"goodsListMai"])
        {
            Product *maiPro = [[Product alloc]init];
            maiPro.productID = [self isEmptyOfString:[maiDict objectForKey:@"goodsID"]]==NO?[maiDict objectForKey:@"goodsID"]:@"";
            maiPro.attrValue =[self isEmptyOfString:[maiDict objectForKey:@"attrValue"]]==NO? [maiDict objectForKey:@"attrValue"]:@"";
            maiPro.sellPrice =[self isEmptyOfString:[maiDict objectForKey:@"privce"]]==NO? [[maiDict objectForKey:@"privce"] floatValue]:0.0;
            maiPro.commodityName =[self isEmptyOfString:[maiDict objectForKey:@"goodsName"]]==NO? [maiDict objectForKey:@"goodsName"]:@"";
            maiPro.catID = [self isEmptyOfString:[maiDict objectForKey:@"category"]]==NO?[maiDict objectForKey:@"category"]:@"";
            maiPro.count = 1;
            [self.buyArray addObject:maiPro];
        }
    }
    if([self whetherDataNeeded:[dict objectForKey:@"goodsListZen"]])
    {
        for(NSDictionary *zengDict in [dict objectForKey:@"goodsListZen"])
        {
            Product *maiPro = [[Product alloc]init];
            maiPro.productID = [self isEmptyOfString:[zengDict objectForKey:@"goodsID"]]==NO?[zengDict objectForKey:@"goodsID"]:@"";
            maiPro.attrValue = [self isEmptyOfString:[zengDict objectForKey:@"attrValue"]]==NO?[zengDict objectForKey:@"attrValue"]:@"";
            maiPro.commodityName = [self isEmptyOfString:[zengDict objectForKey:@"goodsName"]]==NO?[zengDict objectForKey:@"goodsName"]:@"";
            maiPro.sellPrice = [self isEmptyOfString:[zengDict objectForKey:@"privce"]]==NO?[[zengDict objectForKey:@"privce"] floatValue]:0.0;
            maiPro.catID = [self isEmptyOfString:[zengDict objectForKey:@"category"]]==NO?[zengDict objectForKey:@"category"]:@"";
            maiPro.count = 1;
            [self.sendArray addObject:maiPro];
        }
    }
    return self;
}
-(BOOL)isEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return NO;
    }
    return YES;
}
-(BOOL)whetherDataNeeded:(id)item
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
@end
