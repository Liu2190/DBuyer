//
//  ShoppingCartModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShoppingCartModel : NSObject
@property(nonatomic,retain)NSMutableArray *allProductArray;//购物车的所有物品
@property(nonatomic,retain)NSMutableArray *selectProductArray;//购物车中选中的物品数组
@property(nonatomic,assign)NSInteger deleteCellRow;//购物车中将要删除的cell所在的row
@property(nonatomic,assign)float totalPrice;//购物车中的总价
@property(nonatomic,assign)BOOL isLogined;//判断用户是否登录
@property (nonatomic,retain)NSString *tipsFromNet;//来自网络的提示信息;
-(id)initShoppingCartModelWith:(NSMutableDictionary *)dict;
-(float)shoppingCartTotalPrice;//购物车选中的物品总价
-(id)initShoppingCartModelWithDBManager;

@end
