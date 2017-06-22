//
//  HomeModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HomeModel : NSObject
@property (nonatomic,retain)NSMutableArray *bannerArray;
@property (nonatomic,retain)NSMutableArray *bannerImageArray;
@property (nonatomic,retain)NSMutableArray *giftArray;
@property (nonatomic,retain)NSMutableArray *quickEnterArray;
@property (nonatomic,retain)NSMutableArray *quickNormalArray;//普通情况下
@property (nonatomic,retain)NSMutableArray *quickHighlightedArray;//高亮情况下
@property (nonatomic,assign)BOOL quickHasData;
@property (nonatomic,retain)NSMutableArray *homeADArray;//首页广告数组；
@property (nonatomic,retain)NSMutableArray *homeADImageUrlArray;
-(void)getDataFromNet:(NSMutableDictionary *)dict;
@end
