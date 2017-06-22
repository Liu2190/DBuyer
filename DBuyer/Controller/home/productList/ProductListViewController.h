//
//  ProductListViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 14-1-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductListViewController : UIViewController

@property (assign, nonatomic)BOOL isCuxiao;
@property (nonatomic, retain) NSString * listID;
@property (nonatomic, retain) NSString * spID;

@property (nonatomic, retain) NSMutableArray * productList;

@end
