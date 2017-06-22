//
//  BargainGoodsViewController.h
//  DBuyer
//
//  Created by DBuyer on 13-11-6.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
enum{
    CharacteristicsGoods = 1,//特色商品
    TheNewMonthly        = 2,//每月新品
    BargainGoods         = 3,//特价商品
    SeasonalGoods        = 4,//应急商品
    FromRecommend        = 5,//推荐商品
    BannerProList        = 6,//轮播图点击进来的商品列表
};
@interface BargainGoodsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *userTable;
    NSString *spID;
    NSString *categoryId;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
    BOOL isFix;
    BOOL isMore;
}

@property (retain, nonatomic) NSString *typeID;
@property (copy, nonatomic) NSDictionary *listDic;
@property (retain, nonatomic) NSString *catName;
@property (nonatomic, assign) int current_page;
@property (nonatomic, assign) int page_count;
@property (nonatomic, assign) int source;
@property (nonatomic, retain) NSString *classId;
@property (nonatomic, retain) NSString *listUrlString;

@end
