//
//  ProductDetail.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProductDetail.h"
#import "AppDelegate.h"
#import "Product.h"
#import "DBManager.h"
@implementation ProductDetail

-(id)init
{
    self = [super init];
    if(self)
    {
        _ID = [[NSString alloc]initWithString:@""];
        _commodityImage = [[NSMutableArray alloc]init];
        _commodityName = [[NSString alloc]initWithString:@""];
        _keyWord = [[NSArray alloc]init];
        _marketPrice = 0.0f;
        _sellPrice = 0.0f;
        _isCollect = NO;
        _afterSaleService = [[NSString alloc]initWithString:@""];
        _recommendProArray = [[NSMutableArray alloc]init];
        _recommendType = 0;
        _introduceDict = [[NSMutableDictionary alloc]init];
        _isLogined = YES;
        _shareImageURL = [[NSString alloc]initWithString:@""];
        _buyCount = 1;
        _type = 0;
        _categoryID = [[NSString alloc]initWithString:@""];
        _isBuyNow = NO;
        _realInventory = [[NSString alloc]initWithString:@""];
        _virtualInventory = [[NSString alloc]initWithString:@""];
        _isOpen = NO;
        _isPlan = NO;
        _isSalesOpen = NO;
        _salesPromotion = [[NSString alloc]initWithString:@""];
    }
    return self;
}
-(id)initProductModalWithDic:(NSDictionary *)dic AndIsLogin:(BOOL)isLogin WithType:(int)thisType AndCatID:(NSString *)catID{
    [self init];
    /*
     {
     mapCar =     {
     count = 3;
     msg = "\U67e5\U8be2\U6210\U529f";
     status = 0;
     };
     mapfuwu =     {
     list =         (
     {
     ID = 1;
     content = "\U5c1a\U8d85\U5e02BHG\U627f\U8bfa\Uff1a\U534e\U8054\U8d85\U5e02\U89c4\U5b9a\U9000\U6362\U8d27\U8303\U56f4\U5185\U7684\U5546\U54c1\Uff0c\U5982\U56e0\U8d28\U91cf\U95ee\U9898\Uff0c\U81ea\U552e\U51fa\U4e4b\U65e5\Uff08\U4ee5\U5b9e\U9645\U6536\U8d27\U65e5\U671f\U4e3a\U51c6\Uff09\U8d777\U65e5\U5185\U53ef\U4ee5\U9000\U8d27\Uff0c15\U65e5\U5185\U53ef\U4ee5\U6362\U8d27\Uff0c\U5ba2\U6237\U53ef\U4e0e\U5c1a\U8d85\U5e02BHG\U7684\U5ba2\U670d\U4e2d\U5fc3\U8054\U7cfb\U529e\U7406\U9000\U6362\U8d27\U4e8b\U5b9c\U3002";
     id = 1;
     type = 0;
     }
     );
     msg = "\U67e5\U8be2\U6210\U529f";
     status = 0;
     };
     mapinfo =     {
     collect = 0;
     commodityList =         {
     ID = 76643b93701144ea929697073008d5c7;
     caseOne = 0;
     commodityImage = "http://dbuyer.com.cn/appImage/8711574515365D640x360a.JPG";
     commodityName = "\U4f26\U52c3\U6717\U5564\U9152330ml";
     keyWord = "\U66fc\U8d6b";
     marketPrice = "8.9";
     realInventory = 500;
     sellPrice = "8.9";
     virtualInventory = 1;
     };
     plan = 0;
     };
     mapjieshao =     {
     commodityDescription =         (
     {
     ID = 76643b93701144ea929697073008d5c7;
     "\U5305    \U88c5" = "\U542c";
     "\U5546\U54c1\U63cf\U8ff0" = "\U4f26\U52c3\U6717\U5564\U9152330ml";
     "\U5546\U54c1\U89c4\U683c" = "<null>";
     }
     );
     msg = "\U64cd\U4f5c\U6210\U529f";
     status = 0;
     };
     tuijian =     {
     "current_page" = 1;
     msg = "\U67e5\U8be2\U6210\U529f";
     "page_count" = 23;
     recommendCommodity =         (
     {
     brand = "\U66fc\U8d6b";
     id = 0348c9f6f0ad4eccb2f61a99993e35fd;
     "pic_url" = "http://dbuyer.com.cn/appImage/8711574519028L168x168.jpg";
     price = "11.6";
     title = "\U4f26\U52c3\U6717\U5564\U9152330ml";
     },
     {
     brand = "\U5b9d\U9f0e";
     id = e2a4311eb70347f287764b8486a99f9a;
     "pic_url" = "http://dbuyer.com.cn/appImage/5450154440019L168x168.jpg";
     price = "19.9";
     title = "\U5b9d\U9f0e\U7279\U9009\U5564\U9152330ml/\U74f6";
     },
     {
     brand = "\U5b9d\U9f0e";
     id = 9d6fee581280410390988ba5250d1ebf;
     "pic_url" = "http://dbuyer.com.cn/appImage/5450154041018L168x168.jpg";
     price = "16.8";
     title = "\U5b9d\U9f0e\U7eaf\U751f\U5564\U9152330ml/\U74f6";
     }
     );
     status = 0;
     type = 0;
     };
     }
     */
    if([self whetherDictNeeded:[[dic objectForKey:@"mapinfo"] objectForKey:@"commodityList"]])
    {
        NSDictionary *productDict = [[dic objectForKey:@"mapinfo"] objectForKey:@"commodityList"];
        self.ID = [self notEmptyOfString:[productDict objectForKey:@"ID"]]?[productDict objectForKey:@"ID"]:@"";
        self.commodityName = [self notEmptyOfString:[productDict objectForKey:@"commodityName"]]?[productDict objectForKey:@"commodityName"]:@"";
        if([self notEmptyOfString:[productDict objectForKey:@"commodityImage"]])
        {
           [self.commodityImage addObjectsFromArray:[[productDict objectForKey:@"commodityImage"]componentsSeparatedByString:@","]];
            self.shareImageURL = [[[productDict objectForKey:@"commodityImage"]componentsSeparatedByString:@","]objectAtIndex:0];//分享的图片为当前轮播图的第一张
        }
        if([self notEmptyOfString:[productDict objectForKey:@"keyWord"]])
        {
            NSString * resultStr = [[productDict objectForKey:@"keyWord"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            if([resultStr length]!=0)
            {
                if([resultStr rangeOfString:@","].length>0) {
                    self.keyWord = [resultStr componentsSeparatedByString:@","];
                }
                else if([resultStr rangeOfString:@"，"].length>0)
                {
                    self.keyWord = [resultStr componentsSeparatedByString:@"，"];
                }
                else
                {
                    self.keyWord = [resultStr componentsSeparatedByString:@"，"];
                }
                
            }
        }
        self.realInventory = [self notEmptyOfString:[productDict objectForKey:@"realInventory"]]?[NSString stringWithFormat:@"%d",[[productDict objectForKey:@"realInventory"] integerValue]]:@"";
        self.virtualInventory = [self notEmptyOfString:[productDict objectForKey:@"virtualInventory"]]?[NSString stringWithFormat:@"%d",[[productDict objectForKey:@"virtualInventory"] integerValue]]:@"";
        self.marketPrice = [self notEmptyOfString:[productDict objectForKey:@"marketPrice"]]?[[productDict objectForKey:@"marketPrice"] floatValue]:0;
        self.sellPrice = [self notEmptyOfString:[productDict objectForKey:@"sellPrice"]]?[[productDict objectForKey:@"sellPrice"] floatValue]:0;
    }
    if([self notEmptyOfString:[[dic objectForKey:@"mapinfo"]objectForKey:@"collect"]])
    {
        self.isCollect = ([[[dic objectForKey:@"mapinfo"]objectForKey:@"collect"]intValue]==1)? YES:NO;
    }
    self.isLogined = isLogin;//判断用户是否登录
    if(isLogin)
    {
        self.isPlan = [[DBManager sharedDatabase] isExistInShoppinglist:self.ID];
    }
//    if(isLogin)
//    {
//        //登录
//        if([self whetherDictNeeded:[dic objectForKey:@"mapCar"]])
//        {
//            self.countInCart = [self notEmptyOfString:[[dic objectForKey:@"mapCar"] objectForKey:@"count"]]?[[[dic objectForKey:@"mapCar"] objectForKey:@"count"] integerValue]:0;
//        }
//    }
//    else
//    {
//        //未登录
//        AppDelegate *thisDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        self.countInCart = thisDelegate.countOfCart;
//    }
    self.buyCount = 1;
    self.type = thisType;
    self.categoryID = thisType == 1? catID:@"";
    if([self whetherDictNeeded:[dic objectForKey:@"mapfuwu"]])
    {
        if([self whetherArrayNeeded:[[dic objectForKey:@"mapfuwu"] objectForKey:@"list"]])
        {
            for(NSDictionary *fuwuDict in [[dic objectForKey:@"mapfuwu"] objectForKey:@"list"])
            {
                self.afterSaleService = [self notEmptyOfString:[fuwuDict objectForKeyedSubscript:@"content"]]?[fuwuDict objectForKeyedSubscript:@"content"]:@"";
            }
        }
    }
    if([self whetherArrayNeeded:[[dic objectForKey:@"mapjieshao"] objectForKey:@"commodityDescription"]])
    {
        for(NSDictionary *jieshaoDict in [[dic objectForKey:@"mapjieshao"] objectForKey:@"commodityDescription"])
        {
            for(NSString *key in [jieshaoDict allKeys])
            {
               /* if([key isEqualToString:@"ID"])
                {
                    
                }
                else
                {
                  */  [self.introduceDict setObject:[jieshaoDict objectForKey:key] forKey:key];
               // }
            }
        }
    }
    if([self whetherArrayNeeded:[[dic objectForKey:@"tuijian"] objectForKey:@"recommendCommodity"]])
    {
        self.recommendType = [[[dic objectForKey:@"tuijian"] objectForKey:@"type"] intValue];
        //是否有数据
        for(NSDictionary *reDict in [[dic objectForKey:@"tuijian"] objectForKey:@"recommendCommodity"])
        {
            Product *recommendPro = [[Product alloc]init];
            recommendPro.productID =[self notEmptyOfString:[reDict objectForKey:@"id"]]? [reDict objectForKey:@"id"]:@"";
            recommendPro.attrValue = [self notEmptyOfString:[reDict objectForKey:@"pic_url"]]? [reDict objectForKey:@"pic_url"]:@"";
            recommendPro.commodityName = [self notEmptyOfString:[reDict objectForKey:@"title"]]? [reDict objectForKey:@"title"]:@"";
            recommendPro.sellPrice = [self notEmptyOfString:[reDict objectForKey:@"price"]]? [[reDict objectForKey:@"price"] floatValue]:0;
            [self.recommendProArray addObject:recommendPro];
        }
    }
    
    return self;
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
