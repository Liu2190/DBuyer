//
//  TwoSearchNilViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-11-14.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanModal.h"
@interface SecondSearchNilViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *userTable;
    NSMutableArray *userArray;
    
    NSMutableString *strName;
    NSMutableString *imageFile;
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
}
@property(nonatomic,retain)NSString *searchText;
@property(nonatomic,retain)NSString *planID;
@property(nonatomic,retain)NSMutableDictionary *dictArray;
@property(nonatomic,retain)PlanModal *plan;
@end
