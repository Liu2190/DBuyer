//
//  CharacteristicViewController.m
//  DBuyer
//
//  Created by DBuyer on 13-11-5.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "CharacteristicViewController.h"
#import "BargainGoodsViewController.h"
#import "MD5.h"
#import "TimeStamp.h"
#import "UIDevice+Resolutions.h"
#import "NavigationBarView.h"
#import "CharacteristicCell.h"
#import "StartPoint.h"
#import "BargainViewController.h"

#import "HomeSever.h"
#import "TServerFactory.h"
#import "TUtilities.h"

@interface CharacteristicViewController () <NavigationBarViewDelegate> {
    NavigationBarView * navigationView;
}
@end


@implementation CharacteristicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        secondTitle = [[NSString alloc]init];
        _typeID=[[NSString alloc]init];
        thisTypeID = [[NSString alloc]init];
        classId = [[NSString alloc]init];
    }
    
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
-(void)setUserArray:(NSMutableArray *)arr{
    
    if (![arr isEqualToArray:_userArray]) {
        
        _userArray = [arr copy];
        userTable=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, WindowHeight-TabbarHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
        userTable.delegate=self;
        userTable.dataSource=self;
        userTable.showsVerticalScrollIndicator = NO;
        userTable.backgroundColor=[UIColor colorWithRed:239/255.0 green:237/255.0 blue:216/255.0 alpha:1];
        userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview:userTable];
        tableHeight = _userArray.count*80>userTable.frame.size.height?_userArray.count*70:userTable.frame.size.height;
        userTable.contentSize = CGSizeMake(320, tableHeight);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=BACKCOLOR;
    [self.navigationController.navigationBar setHidden:YES];
    navigationView = [NavigationBarView navigationBarView];
    [navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"]
                      rightImage:nil
                      titleImage:nil
                           title:self.catName];
    navigationView.delegate = self;
    [self.view addSubview:navigationView];
}
- (void)setCatName:(NSString *)catName
{
    if (_catName != catName) {
        _catName = catName;
        navigationView.titleLabel.text = catName;
    }
}
#pragma mark navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CharacteristicCell heightOfCell] + 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_userArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"CellItem";
    CharacteristicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell = [CharacteristicCell characteristicCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text=[[_userArray objectAtIndex:indexPath.row] objectForKey:@"caption"];
    cell.subTitleLabel.text =[[_userArray objectAtIndex:indexPath.row] objectForKey:@"caption"];
    cell.iconImageView.image = [UIImage imageNamed:@"1.png"];

    userTable.contentSize = CGSizeMake(320, tableHeight);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    thisTypeID = [[_userArray objectAtIndex:[indexPath row]] objectForKey:@"ID"];
    secondTitle = [[_userArray objectAtIndex:[indexPath row]] objectForKey:@"caption"];
    classId = [[_userArray objectAtIndex:[indexPath row]] objectForKey:@"ID"];
    
    if ([_typeID integerValue] == 1) {
        BargainViewController *bar = [[BargainViewController alloc]initWithNavigationTitle:secondTitle];
        bar.type = TeseGoods;
        bar.parentId = classId;
        [self.navigationController pushViewController:bar animated:YES];
        
    }else if ([_typeID integerValue] == 2){
        BargainViewController *bar = [[BargainViewController alloc]initWithNavigationTitle:secondTitle];
        bar.type = MeiyueXinpinGoods;
        bar.parentId = classId;
        [self.navigationController pushViewController:bar animated:YES];
        
    }else if ([_typeID integerValue] == 4){
        BargainViewController *bar = [[BargainViewController alloc]initWithNavigationTitle:secondTitle];
        bar.type = PaihangGoods;
        bar.parentId = classId;
        [self.navigationController pushViewController:bar animated:YES];
    }
}

@end
