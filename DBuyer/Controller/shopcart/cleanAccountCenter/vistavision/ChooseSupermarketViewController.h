//
//  ChooseSupermarketViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SqliteMarketObject.h"


@protocol ChooseSupermarketViewControllerDelegate <NSObject>

-(void)returnSelectedMarket:(SqliteMarketObject *)market;

@end

@interface ChooseSupermarketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{


}
@property (nonatomic,retain) NSMutableArray *needShowAreaArray;
@property (nonatomic,retain) NSMutableArray *needShowMarketArray;

@property (nonatomic,retain) NSString *versionNumber;
@property (retain, nonatomic) IBOutlet UIImageView *img1;

@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UIButton *fenxiang;
@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)id delegate1;
- (IBAction)btnClick:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *shengbianhualian;
@property (retain, nonatomic) IBOutlet UITableView *userTable;

@property (retain, nonatomic) IBOutlet UITableView *contentTable;
@property (retain, nonatomic) IBOutlet UIImageView *topbar;

@property (nonatomic,retain) SqliteMarketObject * market;
@property (nonatomic,assign) NSInteger marketType;




@end
