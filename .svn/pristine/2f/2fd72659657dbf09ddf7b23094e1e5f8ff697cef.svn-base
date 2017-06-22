//
//  BargainModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BargainModel.h"
#import "Product.h"
@implementation BargainModel
-(id)init
{
    self = [super init];
    if(self)
    {
        _productListArray = [[NSMutableArray alloc]init];
        _bHModel = [[BargainHeaderModel alloc]init];
    }
    return self;
}
-(void)getDataWith:(NSMutableDictionary *)dict
{
    /*
     {
     activityintro =     (
     {
     flag = 1;
     "interface_url" = "http://www.dbuyer.com.cn/market/vip_ad.htm";
     jumptype = 0;
     "pic_url" = "http://www.dbuyer.cn/image5/asksD640x360.png";
     sharetext = "\U6211\U5728\U5c1a\U8d85\U5e02BHG-iPhone\U624b\U673a\U5ba2\U6237\U7aef\U4e0a\U53d1\U73b0\U4e86\U4e00\U4e2a\U6d3b\U52a8\Uff0c\U8d85\U5212\U7b97\Uff0c\U670b\U53cb\U4eec\U8d76\U5feb\U6765\U770b\U4e00\U4e0b\U3002\U4e0b\U8f7d\U5c1a\U8d85\U5e02BHG-iPhone\U5ba2\U6237\U7aef\Uff1ahttp://dbuyer.cn/downloads";
     }
     );
     ask =     (
     {
     flag = 0;
     "interface_url" = "interface/commidty/queryClassDoorsNewList?classId=6&goodsClass=2";
     jumptype = 0;
     "pic_url" = "";
     sharetext = "\U6211\U5728\U5c1a\U8d85\U5e02BHG-iPhone\U624b\U673a\U5ba2\U6237\U7aef\U4e0a\U53d1\U73b0\U4e86\U4e00\U4e2a\U6d3b\U52a8\Uff0c\U8d85\U5212\U7b97\Uff0c\U670b\U53cb\U4eec\U8d76\U5feb\U6765\U770b\U4e00\U4e0b\U3002\U4e0b\U8f7d\U5c1a\U8d85\U5e02BHG-iPhone\U5ba2\U6237\U7aef\Uff1ahttp://dbuyer.cn/downloads";
     }
     );
     commodityList =     (
     {
     ID = C61AF40F70900002EC2897F7893019B9;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/7441001617010L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U53cc\U6995\U6811\U9999\U8349\U725b\U5976250ml";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 40;
     sellPrice = "8.9";
     },
     {
     ID = C61AF3B8DED000026EAA878415548650;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/7441001615009L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U53cc\U6995\U6811\U5de7\U514b\U529b\U725b\U5976250ml";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 40;
     sellPrice = "8.9";
     },
     {
     ID = C61AF2C5C7400002258185B116B0126A;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/7441001601071L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U53cc\U6995\U6811\U8d85\U9ad8\U6e29\U706d\U83cc\U5168\U8102\U7eaf\U725b\U59761L";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 66;
     sellPrice = 16;
     },
     {
     ID = C61AF27D824000022DE311004A701688;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/6004944000243L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U745e\U8d1d\U514b\U7a96\U85cf\U7cfb\U5217\U54c1\U4e50\U73e0\U5e72\U7ea2\U8461\U8404\U9152";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 296;
     sellPrice = 207;
     },
     {
     ID = C61AF0D3B45000029C4FAC50F298D1A0;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/6001240200056L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U897f\U745e\U65af\U9c9c\U6a59\U6df7\U5408\U679c\U6c41200ml";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 30;
     sellPrice = "6.9";
     },
     {
     ID = C61AEC7E4DF000024EAD1B531FCD8A40;
     categoryID = 66;
     commodityImage = "http://www.dbuyer.cn/image5/6001240100257L168x168.JPG";
     commodityName = "\U9650\U65f6\U4f18\U60e0 \U56fd\U6295\U51fa\U54c1 \U897f\U745e\U65af\U8292\U679c\U9999\U68a8\U6df7\U5408\U679c\U6c411L";
     description = "<null>";
     keyWord = "\U9650\U65f6\U4f18\U60e0";
     marketPrice = 85;
     sellPrice = "18.8";
     }
     );
     "current_page" = 1;
     msg = "\U6b63\U786e\U8fd4\U56de";
     "page_count" = 1;
     status = 0;
     }
     */
     if([dict objectForKey:@"commodityList"])
     {
         NSArray *array1=[dict objectForKey:@"commodityList"];
         for(NSDictionary *dict1 in array1)
         {
            Product * product = [[Product alloc] init] ;
             product.commodityName = [dict1 objectForKey:@"commodityName"];
             product.attrValue = [dict1 objectForKey:@"commodityImage"];
             product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
             product.type = [[dict1 objectForKey:@"marketPrice"] intValue];
             product.sellPrice = [[dict1 objectForKey:@"sellPrice"] floatValue];
             product.goodsID = [dict1 objectForKey:@"ID"] ;
             product.keyWord = [dict1 objectForKey:@"keyWord"];
             product.catID = [dict1 objectForKey:@"categoryID"];
             product.productDescription = [dict1 objectForKey:@"description"];//商品的每条描述
             [self.productListArray addObject:product];
         }
     }
         if([dict objectForKey:@"recommendCommodity"])
         {
             NSArray *array1=[dict objectForKey:@"recommendCommodity"];
             for(NSDictionary *dict1 in array1)
             {
                 Product * product = [[Product alloc] init] ;
                 product.commodityName = [dict1 objectForKey:@"title"];
                 product.attrValue = [dict1 objectForKey:@"pic_url"];
                 product.marketPrice = [[dict1 objectForKey:@"marketPrice"] floatValue];
                 product.sellPrice = [[dict1 objectForKey:@"price"] floatValue];
                 product.goodsID = [dict1 objectForKey:@"id"] ;
                 product.keyWord = [dict1 objectForKey:@"keyWord"];
                 product.productDescription = [dict1 objectForKey:@"description"];
                 [self.productListArray addObject:product];
             }
         }
    [self.bHModel setBargainHeaderModelWith:dict];
}
-(BOOL)notEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
-(BOOL)whetherDictNeeded:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        if([item isKindOfClass:[NSDictionary class]])
        {
            return YES;
        }
    }
    return NO;
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
@end
