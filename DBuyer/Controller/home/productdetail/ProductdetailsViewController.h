//
//  ProductdetailsViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-31.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ProductdetailsViewController:UIViewController
@property (assign, nonatomic)int type;
@property (retain, nonatomic)NSString *catID;
@property (nonatomic,retain) NSDictionary * detailDict;
@property (nonatomic,retain)NSString *productId;
@end
