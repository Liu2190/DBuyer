//
//  GiftCell.h
//  DBuyer
//
//  Created by lu gang on 13-12-9.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftCell : NSObject

@property (strong, nonatomic) NSString *gid;                // 礼包ID
@property (strong, nonatomic) NSString *title;              // 礼包名称
@property (assign, nonatomic) float price;                  // 礼包总价格
@property (assign, nonatomic) float savePrice;              // 貌似是节省了多少
@property (strong, nonatomic) NSMutableArray *nameList;     //
@property (assign, nonatomic) int tpye;
@property (strong, nonatomic) NSString *boxPicUrl;          // 礼包图片

@property (nonatomic, assign) NSString * boxDescription;


// 通过字典初始化
- (id)initWithDictionary:(NSDictionary *)dic;

+ (id)giftCellWithDictionary:(NSDictionary *)dic;
- (void)getDataFromHomeDict:(NSDictionary *)dict;
@end