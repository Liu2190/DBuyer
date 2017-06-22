//
//  BargainModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BargainHeaderModel.h"
@interface BargainModel : NSObject
@property (nonatomic,retain)NSMutableArray *productListArray;
@property (nonatomic,retain)BargainHeaderModel *bHModel;
-(void)getDataWith:(NSMutableDictionary *)dict;
@end
