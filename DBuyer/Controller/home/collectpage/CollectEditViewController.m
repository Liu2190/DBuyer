//
//  CollectEditViewController.m
//  DBuyer
//
//  Created by chenpeng on 14-1-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "CollectEditViewController.h"
#import "Product.h"
#import "CollectEditCell.h"
#import "WCAlertView.h"
#import "DBManager.h"
#import "NavigationBarView.h"

@interface CollectEditViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, NavigationBarViewDelegate>
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSIndexPath * deleteCell;

@property (nonatomic, assign) UIButton * leftButton;
@property (nonatomic, assign) UIButton * rightButton;

@property (nonatomic, assign) NSMutableArray * selfProductList;

@end

@implementation CollectEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.productList = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc
{
    self.deleteCell = nil;
    self.tableView = nil;
    self.productList = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    NavigationBarView * navigationBar = [NavigationBarView navigationBarView];
    [navigationBar setLeftImage:[UIImage imageNamed:@"Image_Collect_05"]
                     rightImage:[UIImage imageNamed:@"Image_Collect_07"]
                     titleImage:nil
                          title:@"收藏夹"];
    navigationBar.delegate = self;
    [self.view addSubview:navigationBar];

    // 设置tableView视图
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, [navigationBar bottom], self.view.frame.size.width, WindowHeight - [navigationBar bottom] - TabbarHeight)] autorelease];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:self.tableView];
    // 设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
#pragma mark - navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 下载数据完成
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];

    if ([[dict objectForKey:@"status"] intValue] != 0) {
        [self showError:[dict objectForKey:@"msg"]];
    } else {
        switch (hd.type) {
            case 11188:
            {
                // 删除视图行
                [self.productList removeObjectAtIndex:self.deleteCell.row];
                [self.tableView deleteRowsAtIndexPaths:@[self.deleteCell] withRowAnimation:UITableViewRowAnimationLeft];
            }
            break;
        }
    }
}
#pragma mark - UITableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CollectEditCell heightOfCell];
}
#pragma mark - UITableView DateSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"CellItem";
    CollectEditCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    
    if(cell==nil){
        cell = [CollectEditCell collectEditCell];
        // 设置cell事件
        [cell addtarget:self
           deleteAction:@selector(deleteButtonClicked:)
         joinPlanAction:@selector(joinPlanButtonClicked:)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 显示商品
    Product *product = [self.productList objectAtIndex:indexPath.row];
    [cell showWithProduct:product];
    
    // 是否已经收藏
    if([[DBManager sharedDatabase] isExistInShoppinglist:product.productID] == NO) {
        cell.joinPlanButton.enabled = YES;
    } else {
        cell.joinPlanButton.enabled = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - collectEditCell代理方法
- (void)deleteButtonClicked:(CollectEditCell *)sender
{
    // 记录删除行
    self.deleteCell = [self.tableView indexPathForCell:sender];
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"是否确定要删除？"
                                                message:@"删除后将无法取回"
                                               delegate:self
                                      cancelButtonTitle:@"否"
                                      otherButtonTitles:@"是", nil];
    [al show];
    [al release];
}
- (void)joinPlanButtonClicked:(CollectEditCell *)sender
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
    Product * product = [self.productList objectAtIndex:indexPath.row];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:product.productID forKey:@"planid"];
    [dict setObject:product.attrValue forKey:@"urlimage"];
    [dict setObject:@"0" forKey:@"status"];
    [dict setObject:product.commodityName forKey:@"planname"];
    [dict setObject:@"2" forKey:@"type"];
    [dict setObject:[self generateCompareTime] forKey:@"comparetime"];
    [dict setObject:[self generateRemindTime] forKey:@"remindtime"];
    
    [[DBManager sharedDatabase] insertintoShoppinglist:dict];
    
    [WCAlertView showAlertWithTitle:@"提示"
                            message:@"添加计划成功"
                 customizationBlock:^(WCAlertView * alertView1) {
                                        alertView1.style=WCAlertViewStyleBlack;
                                    }
                    completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                                        if(buttonIndex == 0) {
                                            [self.tableView reloadData];
                                        }
                                    }
                  cancelButtonTitle:@"确定"
                  otherButtonTitles:nil,nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        Product * product = [self.productList objectAtIndex:self.deleteCell.row];
        //从网络数据库中删除该商品
        HttpDownload *hd=[[HttpDownload alloc]init];
        hd.delegate=self;
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",product.type],@"type",[NSString stringWithFormat:@"%@",product.catID],@"categoryID",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",product.productID,@"id",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
        [hd getResultData:dict baseUrl:[NSString stringWithFormat:deleteShouCang,serviceHost]];
        hd.type =11188;
        hd.method=@selector(downloadComplete:);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
