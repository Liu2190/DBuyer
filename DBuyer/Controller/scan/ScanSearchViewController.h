//
//  ScanSearchViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-11-26.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *userTable;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
}
@property(nonatomic,retain)NSMutableArray *searchArray;
@end
