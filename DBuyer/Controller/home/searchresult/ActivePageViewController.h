//
//  ActivePageViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TPullUPRefreshController.h"

@interface ActivePageViewController : TPullUPRefreshController
@property (nonatomic,retain)NSString *urlString;
@property (nonatomic,retain)NSString *titleName;
@end
