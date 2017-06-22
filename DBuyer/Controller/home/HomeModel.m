//
//  HomeModel.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "HomeModel.h"
#import "GiftCell.h"
#import "HomeBannerModel.h"
#import "HomeQuickEnterModel.h"
#import "UIButton+WebCache.h"
@implementation HomeModel
-(id)init
{
    self =[super init];
    if(self)
    {
        _bannerArray = [[NSMutableArray alloc]init];
        _quickEnterArray = [[NSMutableArray alloc]init];
        _giftArray = [[NSMutableArray alloc]init];
        _bannerImageArray =[[NSMutableArray alloc]init];
        _quickNormalArray = [[NSMutableArray alloc]initWithObjects:@"homeCategory",@"quickEntry_meiyuexinpin",@"quickEntry_tejiashangpin",@"quickEntry_vip",/*@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",*/@"quickEntry_shenbianhualian",@"quickEntry_dalibao",@"quickEntry_shoucang",@"quickEntry_wodedingdan", nil];
        _homeADArray= [[NSMutableArray alloc]init];
        _quickHighlightedArray = [[NSMutableArray alloc]initWithObjects:@"homeCategory-s",@"quickEntry_meiyuexinpin1",@"quickEntry_tejiashangpin1",@"quickEntry_vips",/*@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",@"quickEnterPlaceHoderImage",*/@"quickEntry_shenbianhualian1",@"quickEntry_dalibao1",@"quickEntry_shoucang1",@"quickEntry_wodedingdan",nil];
        _quickHasData = NO;
        _homeADImageUrlArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)getDataFromNet:(NSMutableDictionary *)dict
{
    //轮播图数据
    if([self whetherDataNeeded:[[dict objectForKey:@"bannerList"] objectForKey:@"banner_list"]] == YES)
    {
        [self.bannerArray removeAllObjects];
        [self.bannerImageArray removeAllObjects];
        NSMutableArray *imageUrlArray = [[dict objectForKey:@"bannerList"] objectForKey:@"banner_list"];
        for (NSMutableDictionary * dic in imageUrlArray) {
            HomeBannerModel *banner = [[HomeBannerModel alloc]initDataWithDict:dic];
            [self.bannerImageArray addObject:banner.imgURL];
            [self.bannerArray addObject:banner];
        }
    }
    
    
    //默认搜索数据
    if([self whetherDataNeeded:[[dict objectForKey:@"searchList"] objectForKey:@"list"]]==YES)
        {
            for(NSDictionary  *dic in [[dict objectForKey:@"searchList"] objectForKey:@"list"] )
            {
                if([self isEmptyOfString:[dic objectForKey:@"codeName"]]==NO)
                {
                    NSString *searchText = [NSString stringWithFormat:@"%@",[dic objectForKey:@"codeName"]];
                    [[NSUserDefaults standardUserDefaults] setObject:searchText forKey:dDefaultSearch];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
    
    //快捷入口数据
    if([self whetherDataNeeded:[[dict objectForKey:@"homeList"] objectForKey:@"list"]])
    {
        NSMutableArray *quickArray = [[dict objectForKey:@"homeList"] objectForKey:@"list"];
        if([quickArray count]>0)
        {
            [self.quickEnterArray removeAllObjects];
            //如果快捷入口有数据
            for(int i = 0;i<[quickArray count];i++)
            {
                if( i < 4 )
                {
                    NSMutableDictionary * dic = [quickArray objectAtIndex:i];
                    HomeQuickEnterModel *banner = [[HomeQuickEnterModel alloc]initHomeQuickEnterModelWith:dic];
                    [self.quickEnterArray addObject:banner];
                    [self.quickNormalArray replaceObjectAtIndex:i withObject:banner.dataSourceURL];
                    [self.quickHighlightedArray replaceObjectAtIndex:i withObject: banner.iconURL];
                }
            }
            self.quickHasData = YES;
        }
        else
        {
            self.quickHasData = NO;
        }
    }
        //大礼包数据
    if([self whetherDataNeeded:[[dict objectForKey:@"boxlist"] objectForKey:@"gift_list"]])
    {
        if (self.giftArray.count > 0) {
            [self.giftArray removeAllObjects];
        }
        for(NSDictionary *giftDic in [[dict objectForKey:@"boxlist"] objectForKey:@"gift_list"])
        {
            GiftCell *giftCell = [[GiftCell alloc]init];
            [giftCell getDataFromHomeDict:giftDic];
            [self.giftArray addObject:giftCell];
        }
    }
        //首页广告数据
    if([self whetherDataNeeded:[[dict objectForKey:@"adlist"] objectForKey:@"ad_list"]])
    {
        [self.homeADArray removeAllObjects];
        [self.homeADImageUrlArray removeAllObjects];
        for(NSDictionary *adDict in [[dict objectForKey:@"adlist"] objectForKey:@"ad_list"])
        {
            HomeBannerModel *adModel = [[HomeBannerModel alloc]init];
            adModel.imgURL = [adDict objectForKey:@"imgURL"];//广告的图片URL
            [self.homeADImageUrlArray addObject:[adDict objectForKey:@"imgURL"]];
            adModel.pageID = [adDict objectForKey:@"pageID"];//广告跳转到哪儿 0跳转到webview,1跳转到商品详情，2跳转到商品列表，3跳转到礼包详情，4跳转到礼包列表
            adModel.pageURL = [adDict objectForKey:@"pageURL"];//广告跳转到webview时URL 以及分享的内容
            adModel.resultID = [adDict objectForKey:@"resultID"];//广告跳转到到商品详情或者礼包详情时的ID
            adModel.sharetext = [adDict objectForKey:@"sharetext"];//广告跳转到到webview时附带的分享的标题
            [self.homeADArray addObject:adModel];
        }
    }
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
