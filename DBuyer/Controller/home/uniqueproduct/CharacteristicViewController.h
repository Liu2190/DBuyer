//
//  CharacteristicViewController.h
//  DBuyer
//
//  Created by DBuyer on 13-11-5.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpDownload.h"
@interface CharacteristicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int tableHeight;
    UITableView *userTable;
    NSString *secondTitle;
    NSString *thisTypeID;
    NSString *classId;
}

//debug-lu tpyeID区分二级
@property (retain, nonatomic)NSString *typeID;
@property (copy, nonatomic)NSString *catName;
@property (copy, nonatomic)NSMutableArray *userArray;
@end
