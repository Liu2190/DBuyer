//
//  TwoSearchNilViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-11-14.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "SecondSearchNilViewController.h"
#import "LXD.h"
#import "PlanCell.h"
#import "HttpDownload.h"
#import "UIImageView+WebCache.h"
#import "WCAlertView.h"
#import "DBManager.h"
#import "LeveyTabBarController.h"
#import "Product.h"
#import "StartPoint.h"
@interface SecondSearchNilViewController (){
    NSString *productID;
    Product *thisProduct;
}

@end

@implementation SecondSearchNilViewController
@synthesize searchText,planID,dictArray,plan;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        productID=[[NSString alloc]init];
        thisProduct = [[Product alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.leveyTabBarController hidesTabBar:NO animated:YES];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(void)setNilImage
{
    UIImageView *nilView=[[UIImageView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint]+10, 320, 580.0/2)];
    nilView.userInteractionEnabled=YES;
    [self.view addSubview:nilView];
    UIImageView *titleImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"secsearch_title_image"]];
    titleImage.frame=CGRectMake((320-308/2)/2, 0, 308/2, 25);
    titleImage.userInteractionEnabled=YES;
    [nilView addSubview:titleImage];
    LXD *titleLabel=[[LXD alloc]initWithText:searchText font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 3, 308/2, 20) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    [titleImage addSubview:titleLabel];
    UIImageView *sernilImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"secsearch_nil_image"]];
    sernilImage.frame=CGRectMake((320-308/2)/2, 164/2, 308/2, 282/2);
    sernilImage.userInteractionEnabled=YES;
    [nilView addSubview:sernilImage];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(206/2, 513/2, 250/2, 33);
    [button setTitle:@"返回计划" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(bC:) forControlEvents:UIControlEventTouchUpInside];
    button.userInteractionEnabled=YES;
    [button setBackgroundImage:[UIImage imageNamed:@"pro_confirm_button.png"] forState:UIControlStateNormal];
    for(UIView * v in [button.superview.superview subviews]){
        v.userInteractionEnabled=YES;
    }
    
    [nilView addSubview:button];
}
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        [mainDelegate endLoad];
        if(hd.type==10)
        {
            if([[dict objectForKey:@"status"] intValue]==0){
                 NSMutableArray *array=[dict objectForKey:@"returnlist"];
                for(int i=0;i<[array count];i++){
                    NSDictionary * dict1=[array objectAtIndex:i];
                    Product *product = [[Product alloc]init];
                    product.productID=[dict1 objectForKey:@"ID"];
                    product.attrValue=[dict1 objectForKey:@"commodityImage"];
                    product.commodityName=[dict1 objectForKey:@"title"];
                    product.type=[[dict1 objectForKey:@"type"] intValue];
                    product.sellPrice=[[dict1 objectForKey:@"sellPrice"] floatValue];
                    product.keyWord=[dict1 objectForKey:@"keyWord"];
                    [userArray addObject:product];
                    
                }
                userTable.hidden=NO;
                [userTable reloadData];
            }
            else{
                userTable.hidden=YES;
                [userTable removeFromSuperview];
                [self setNilImage];
                            
            }
        }
        if(hd.type==1989){
            if([[dict objectForKey:@"status"]intValue]==0){
                [self.leveyTabBarController addNumToCarList:[[dict objectForKey:@"count"] stringValue]];
            }
        }
        if(hd.type==11){
            if([[dict objectForKey:@"status"] intValue]==0){
                [self getShoppingCarNumFromNet];
                NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
                [dict1 setObject:thisProduct.productID forKey:@"planid"];
                [dict1 setObject:thisProduct.commodityName forKey:@"planname"];
                [dict1 setObject:thisProduct.attrValue forKey:@"urlimage"];
                [dict1 setObject:@"1" forKey:@"status"];
                [dict1 setObject:@"0" forKey:@"imageid"];
                [dict1 setObject:plan.remindtime forKey:@"remindtime"];
                [dict1 setObject:plan.comparetime forKey:@"comparetime"];
                [dict1 setObject:@"2" forKey:@"type"];
                
                [[DBManager sharedDatabase]deleteItemFromShoppingplanWith:planID];
                [[DBManager sharedDatabase] insertintoShoppinglist:dict1];
                
                [WCAlertView showAlertWithTitle:@"恭喜" message:@"加购物车成功" customizationBlock:^(WCAlertView * alertView1) {
                    alertView1.style=WCAlertViewStyleBlack;
                }completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                    if(buttonIndex==0){
                        
                       [self.navigationController popViewControllerAnimated:YES];
                        
                        
                    }
                    if (buttonIndex==1) {
                        [self.leveyTabBarController setSelectedIndex:3];
                        
                    }
                }cancelButtonTitle:@"返回计划" otherButtonTitles:@"去购物车",nil];
            }
        }
        if(hd.type==12){
            if([[dict objectForKey:@"status"] intValue]==0){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setHidden:YES];
    [self setNavigationBarWithContent:@"购物计划" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    userArray=[[NSMutableArray alloc]init];
    userTable=[[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowHeight, self.view.frame.size.height-[StartPoint startPoint]-TabbarHeight) style:UITableViewStylePlain];
    userTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    userTable.showsVerticalScrollIndicator=NO;
    userTable.delegate=self;
    userTable.dataSource=self;
    userTable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:userTable];
    userTable.hidden=YES;
    mainDelegate=[self mainDelegate];
    [mainDelegate beginLoad];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    hd.type=10;
    thisDownLoad=hd;
    [hd getResultData:[NSMutableDictionary dictionaryWithObjectsAndKeys:searchText,@"title",nil] baseUrl:[NSString stringWithFormat:@"%@interface/search/queryView",serviceHost ]];
}
-(void)leftButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    view.backgroundColor=[UIColor clearColor];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake((320-308/2)/2, 10, 308/2, 25)];
    img1.image=[UIImage imageNamed:@"secsearch_title_image"];
    LXD *titleLabel=[[LXD alloc]initWithText:searchText font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 3, 308/2, 20) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    [img1 addSubview:titleLabel];
    [view addSubview:img1];
    return view;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102.0f;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [userArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName=@"CellItem";
    PlanCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"PlanCell" owner:self options:nil]lastObject];
    }
    Product *product=[userArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.backgroundView.backgroundColor=[UIColor clearColor];
    if([self IsEmptyOfString:product.attrValue]==NO)
    {
        [cell.planImage setImageWithURL:[NSURL URLWithString:product.attrValue]];
    }
    cell.contentLabel.text=product.commodityName;
    cell.xianjia.text=[NSString stringWithFormat:@"%.2f",product.sellPrice];
    cell.delegate=self;
    cell.btnClick.tag=indexPath.row;
    return cell;
}
-(void)pushDetail:(UIButton *)button
{
    thisProduct = [userArray objectAtIndex:button.tag];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    thisDownLoad = hd;
    hd.type=11;
    NSMutableDictionary *dict55=[[NSMutableDictionary alloc]initWithObjectsAndKeys:thisProduct.productID,@"id",@"1",@"count",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",@"0",@"type",nil];
    [hd getResultData:dict55 baseUrl:[NSString stringWithFormat:insertToGoods,serviceHost] ];
    [mainDelegate beginLoad];
}
-(void)bC:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
