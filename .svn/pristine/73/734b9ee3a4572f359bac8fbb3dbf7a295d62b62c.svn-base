//
//  PackagelistViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-11-1.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//
#import "PackagelistViewController.h"
#import "GiftRightView.h"
#import "GiftLeftView.h"
#import "GiftCell.h"
#import "GiftdetailsViewController.h"
#import "StartPoint.h"

#import "GiftSever.h"
#import "TServerFactory.h"
#import "TUtilities.h"

@interface PackagelistViewController()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSMutableArray *boxs;
@property (retain,nonatomic)UITableView *userTable;
@end

@implementation PackagelistViewController
@synthesize boxs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.boxs = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
}

-(void)getDataFromNetWith:(int)type{
    [[TUtilities getInstance]popTarget:self.view status:@"加载中..."];
    [[TServerFactory getServerInstance:@"GiftSever"]doGetPackageListBycallback:^(NSArray *dataArray){
        [[TUtilities getInstance]dismiss];
        [boxs addObjectsFromArray:dataArray];
        [_userTable reloadData];
    } failureCallback:^(NSString *resp){
        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
        [_userTable reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarWithContent:@"礼包列表" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    _userTable=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight-[StartPoint startPoint]-TabbarHeight) style:UITableViewStylePlain];
    _userTable.showsVerticalScrollIndicator = YES;
    _userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    _userTable.delegate=self;
    _userTable.dataSource=self;
    _userTable.backgroundColor=BACKCOLOR;
    [self.view addSubview:_userTable];
    [self getDataFromNetWith:0];
}

-(void)leftButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.boxs.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName=@"CellItem";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    GiftCell *cellDic = (GiftCell *)[self.boxs objectAtIndex:[indexPath row]];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if(indexPath.row%2==0){
        GiftRightView *rightView=[[[NSBundle mainBundle]loadNibNamed:@"GiftRightView" owner:self options:nil]lastObject];
        rightView.giftName.text=cellDic.title;
        [rightView.giftImage setImageWithURL:[NSURL URLWithString:cellDic.boxPicUrl]];
        rightView.gitfPrice.text=[NSString stringWithFormat:@"%.2f",cellDic.price];
        rightView.giftDescription.text=[NSString stringWithFormat:@"%@",cellDic.boxDescription];
        rightView.giftSavePrice.text=[NSString stringWithFormat:@"￥%.2f",cellDic.savePrice];
        [cell.contentView addSubview:rightView];
    }
   
    if(indexPath.row%2==1){
        GiftLeftView *leftView=[[[NSBundle mainBundle]loadNibNamed:@"GiftLeftView" owner:self options:nil]lastObject];
        leftView.giftName.text=cellDic.title;
        [leftView.giftImage setImageWithURL:[NSURL URLWithString:cellDic.boxPicUrl]];
        leftView.gitfPrice.text=[NSString stringWithFormat:@"%.2f",cellDic.price];
        leftView.giftDescription.text=[NSString stringWithFormat:@"%@",cellDic.boxDescription];
        leftView.giftSavePrice.text=[NSString stringWithFormat:@"￥%.2f",cellDic.savePrice];
        [cell.contentView addSubview:leftView];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftdetailsViewController *gif=[[GiftdetailsViewController alloc]init];
    GiftCell *cellDic = (GiftCell *)[self.boxs objectAtIndex:[indexPath row]];
    gif.gid = cellDic.gid;
    [self.navigationController pushViewController:gif animated:YES];
}

@end
