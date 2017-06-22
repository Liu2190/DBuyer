//
//  ProductdetailsViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ProductdetailsViewController.h"
#import "StartPoint.h"
#import "ProductDetail.h"
#import "RecommendScrollView.h"
#import "Product.h"
#import "HttpDownload.h"
#import "LoadView.h"
#import "AppDelegate.h"
#import "SettlementViewController.h"
#import "BannerView.h"
#import "ShareView.h"
#import "ToShoppingCartView.h"
#import "keyBoardView.h"
#import "DBManager.h"
#import "ProToCartButton.h"
#import "DBManager.h"
#import "ShoppingCartViewController.h"
#import "ProBannerCell.h"
#import "ProDetailsView.h"
#import "ProButtonCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ProServiceView.h"
#import "ProServiceCell.h"
#import "ProRecommendView.h"
#import "JiesuanViewController.h"

#define ACTIVITYTEXT @"限量特惠，一次最多只能购买5件"
#define BUTTONCENTER CGPointMake(WindowWidth-25, WindowHeight-45)
#define TABLEVIEWCOLOR [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:237.0/255.0 alpha:1]
@interface ProductdetailsViewController ()<UITableViewDataSource,UITableViewDelegate,BannerViewDelegate,RecommendScrollViewDelegate,UITextFieldDelegate,ProRecommendDelegate>
{
    AppDelegate *mainDelegate;
    HttpDownload *thisDownLoad;
}

@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)ProductDetail *thisPro;
@property (nonatomic,retain)ShareView *shareView;
@property (nonatomic,retain)ToShoppingCartView *shopView;
@property (nonatomic,retain)ProToCartButton *shoppingcartButton;
@property (nonatomic,retain)ProDetailsView *proheaderView;
@property (nonatomic,retain)ProServiceView *serviceHeaderView;
@property (nonatomic,retain)UIView *recommandHeaderView;
@property (nonatomic,assign)float serviceHeight;
@property (nonatomic,retain)ProBannerCell *bannerCell;

@end

@implementation ProductdetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.thisPro = [[ProductDetail alloc]init];
        self.catID = [[NSString alloc]init];
        self.serviceHeight = 0.0f;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [mainDelegate endLoad];
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    if(self.shoppingcartButton!=nil)
    {
        [self.shoppingcartButton setShoppingCartNumWith:mainDelegate.countOfCart];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if([self isAlreadyLogined])
    {
        //如果有用户登录，把商品数据提交到网络
        [[self mainDelegate]submitProToNet];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addLoadView];
    mainDelegate = [self mainDelegate];
    self.navigationController.navigationBar.hidden = YES;
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    [self setNavigationBarWithContent:@"商品详情" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:[UIImage imageNamed:@"pro_share_image"]];
    
    self.thisPro = [[ProductDetail alloc]initProductModalWithDic:_detailDict AndIsLogin:[self isAlreadyLogined] WithType:_type AndCatID:self.catID];//初始化模型
    self.proheaderView = [[[NSBundle mainBundle]loadNibNamed:@"ProDetailsView" owner:self options:nil]lastObject];
    [self.proheaderView setProDetailViewWith:self.thisPro];
    [self.proheaderView.spreadButton addTarget:self action:@selector(changeIsOpen) forControlEvents:UIControlEventTouchUpInside];
    self.proheaderView.frame = CGRectMake(0, 0, 320, [self.proheaderView heightOfPro]);
    
    self.serviceHeaderView = [[[NSBundle mainBundle]loadNibNamed:@"ProServiceView" owner:self options:nil]lastObject];
    self.serviceHeaderView.sepImage.hidden = YES;
    [self.serviceHeaderView.serviceButton addTarget:self action:@selector(serviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.recommandHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, 50)];
    ProServiceView *rhView = [[[NSBundle mainBundle]loadNibNamed:@"ProServiceView" owner:self options:nil]lastObject];
    CGRect frame = rhView.frame;
    frame.origin.y = 10;
    rhView.frame = frame;
    rhView.serviceLabel.text = @"猜你喜欢";
    rhView.serviceButton.hidden = YES;
    rhView.arrowImage.hidden = YES;
    [self.recommandHeaderView addSubview:rhView];
    self.serviceHeight = [self heightForString:self.thisPro.afterSaleService font:[UIFont systemFontOfSize:12] andWidth:280].height + 20;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,[StartPoint startPoint],WindowWidth, WindowHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = TABLEVIEWCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.shopView = [[[NSBundle mainBundle]loadNibNamed:@"ToShoppingCartView" owner:self options:nil]lastObject];
    self.shopView.countTextField.delegate = self;
    self.shopView.frame = CGRectMake(0, 1000, WindowWidth, WindowHeight);
    keyBoardView *keyBord = [[[NSBundle mainBundle]loadNibNamed:@"keyBoardView" owner:self options:nil]lastObject];
    [keyBord addTarget:self finishAction:@selector(finishEdit:) cancelAction:@selector(cancelEdit:)];
    self.shopView.countTextField.inputAccessoryView = keyBord;
    [self.shopView addAction:self With:@selector(hideShopView) And:@selector(shopViewDecrease) And:@selector(shopViewIncrease) And:@selector(shopViewConfirm)];
    [self.view addSubview:self.shopView];
    
    self.shoppingcartButton = [[[NSBundle mainBundle]loadNibNamed:@"ProToCartButton" owner:self options:nil]lastObject];
    self.shoppingcartButton.frame = CGRectMake(WindowWidth-50, WindowHeight-70, 50, 50);
    [self.shoppingcartButton setShoppingCartNumWith:mainDelegate.countOfCart];
    self.shoppingcartButton.userInteractionEnabled = YES;
    [self.view addSubview:self.shoppingcartButton];
    UIButton *tap =[UIButton buttonWithType:UIButtonTypeCustom];
    tap.frame = CGRectMake(WindowWidth-50, WindowHeight-70, 50, 50);
    [tap addTarget:self action:@selector(ToShoppingCartPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tap];
}
-(void)serviceButtonAction:(UIButton *)button
{
    self.thisPro.isSalesOpen = !self.thisPro.isSalesOpen;
    float hudu = self.thisPro.isSalesOpen == YES?(3.141593/2):(-3.141593/2);
    [UIView animateWithDuration:0.2 delay:0 options:0 animations: ^{
        self.serviceHeaderView.arrowImage.transform = CGAffineTransformRotate(self.serviceHeaderView.arrowImage.transform, hudu);
    } completion: ^(BOOL completed) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:3]  withRowAnimation:UITableViewRowAnimationNone];
    }];
}
//去往购物车页面，购物车有返回按钮，没有tabbar
-(void)ToShoppingCartPage
{
    ShoppingCartViewController *scVC = [[ShoppingCartViewController alloc]initWithNibName:@"ShoppingCartViewController" bundle:nil];
    scVC.isFromHome = YES;
    [self.navigationController pushViewController:scVC animated:YES];
}
#pragma mark - 下载数据
-(void)downloadFail
{
    [thisDownLoad ConnectionCanceled];
    [mainDelegate endLoad];
}
-(void)pleaseCancelLoad{
    //取消菊花
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
    [self.tableView reloadData];
}
-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict) {
        if([[dict objectForKey:@"status"] intValue]==0){
            if (hd.type == 1) {
                [mainDelegate endLoad];
                if([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue]!=0){
                    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                    [al show];
                    return;
                }
                else {
                    ProductdetailsViewController *so = [[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil] ;
                    so.detailDict = dict;
                    [self.navigationController pushViewController:so animated:YES];
                }
            }else if (2 == hd.type)
            {
            }
        }else{
            [self showError:[dict objectForKey:@"msg"]];
        }
    }
}
-(void)changeIsOpen
{
    self.thisPro.isOpen = !self.thisPro.isOpen;
    float hudu = self.thisPro.isOpen == YES?(3.141593/2):(-3.141593/2);
     [UIView animateWithDuration:0.2 delay:0 options:0 animations: ^{
     self.proheaderView.arrowImage.transform = CGAffineTransformRotate(self.proheaderView.arrowImage.transform, hudu);
     } completion: ^(BOOL completed) {
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]  withRowAnimation:UITableViewRowAnimationNone];
     }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1)
    {
        return self.proheaderView;
    }
    if(section == 3)
    {
        return self.serviceHeaderView;
    }
    if(section == 4)
    {
        return self.recommandHeaderView;
    }
    return nil;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1)
    {
        return [self.proheaderView heightOfPro];
    }
    if(section == 3)
    {
        return 40;
    }if(section == 4)
    {
        return 50;
    }
    return 0;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 210.0f;
    }
    else if(indexPath.section == 1)
    {
        return ([[self.thisPro.introduceDict allKeys] count]-1)*26;
    }
    else if(indexPath.section == 2)
    {
        return 120.0;
    }
    else if(indexPath.section == 3)
    {
        return self.serviceHeight;
    }
    else if (indexPath.section == 4)
    {
        return 135.0f;
    }
    return 0;
}
-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return self.thisPro.isOpen==YES?1:0;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return  self.thisPro.isSalesOpen==YES?1:0;
        }
            break;
        case 4:
        {
            return self.thisPro.recommendProArray.count!=0?1:0;
        }
            break;
        default:
            break;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identyfier = @"cell";
    if(indexPath.section == 0)
    {
        //轮播图
        self.bannerCell = [tableView dequeueReusableCellWithIdentifier:identyfier];
        self.bannerCell = [[[NSBundle mainBundle]loadNibNamed:@"ProBannerCell" owner:self options:nil]lastObject];
        BannerView *bannerView = [[BannerView alloc]initWithFrameRect:CGRectMake(0, 0, WindowWidth, 200) ImageArray:self.thisPro.commodityImage TitleArray:nil];
        bannerView.delegate = self;
        bannerView.userInteractionEnabled = YES;
        [self.bannerCell.photoImage addSubview:bannerView];
        [self.bannerCell.collectButton addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerCell setProBannerCellWith:self.thisPro];
        [self.bannerCell bringSubviewToFront:self.bannerCell.collectButton];
        return self.bannerCell;
    }
    else if(indexPath.section == 2)
    {
        //各种按钮
        ProButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProButtonCell" owner:self options:nil]lastObject];
        [cell.gouwucheButton addTarget:self action:@selector(addToCartAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.lijigoumaiButton addTarget:self action:@selector(BuyNow:) forControlEvents:UIControlEventTouchUpInside];
        [cell.jihuaButton addTarget:self action:@selector(toPlanAction) forControlEvents:UIControlEventTouchUpInside];
        [cell setCellValueWith:self.thisPro];
        return cell;
    }
    else if(indexPath.section == 3)
    {
        //售后服务
        ProServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfier];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProServiceCell" owner:self options:nil]lastObject];
        [cell setCellValueWith:self.thisPro.afterSaleService];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identyfier];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selected = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.section == 1)
        {
            //商品键值对
            for(UIView *v in [cell.contentView subviews])
            {
                [v removeFromSuperview];
            }
            UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0,0, WindowWidth, ([[self.thisPro.introduceDict allKeys] count])*26)];
            UIImageView *sepImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 280, 1)];
            sepImage.backgroundColor = [UIColor lightGrayColor];
            [whiteView addSubview:sepImage];
            whiteView.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:whiteView];
            //商品介绍
            NSArray *keyArray=[self.thisPro.introduceDict allKeys];
            for(int i = 0;i<keyArray.count;i++)
            {
                NSString *keyString = [keyArray objectAtIndex:i];
                LXD *keyLabel = [[LXD alloc]initWithText:keyString font:10 textAlight:NSTextAlignmentLeft frame:CGRectMake(20, 5+(i-1)*25, 50, 24) backColor:[UIColor clearColor] textColor:[UIColor darkGrayColor]];
                [whiteView addSubview:keyLabel];
                NSString *valueString = [self IsEmptyOfString:[self.thisPro.introduceDict objectForKey:keyString]]==NO?[self.thisPro.introduceDict objectForKey:keyString]:@"无";
                LXD *valueLabel = [[LXD alloc]initWithText:valueString font:10 textAlight:NSTextAlignmentLeft frame:CGRectMake(76, 5+(i-1)*25, 230, 24) backColor:[UIColor clearColor] textColor:[UIColor darkGrayColor]];
                valueLabel.numberOfLines = 0;
                [whiteView addSubview:valueLabel];
            }
        }
        
        if (indexPath.section == 4)
        {
            //猜你喜欢
            for(UIView *v in [cell.contentView subviews])
            {
                [v removeFromSuperview];
            }
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 135)];
            backView.backgroundColor = [UIColor whiteColor];
            backView.userInteractionEnabled = YES;
            [cell.contentView addSubview:backView];
            //关联数据
            ProRecommendView *recommendView = [[ProRecommendView alloc]initWithArray:self.thisPro.recommendProArray startPoint:CGPointMake(0, 15)];
            recommendView.delegate = self;
            [backView addSubview:recommendView];
        }
        return cell;
    }
}
#pragma mark - 轮播图代理方法
- (void)bannerViewDidClicked:(NSUInteger)index
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:[self.thisPro.commodityImage count]];
    NSURL *srcUrl = [NSURL URLWithString:[self.thisPro.commodityImage objectAtIndex:index]];
    for(int i = 0;i<[self.thisPro.commodityImage count];i++)
    {
        NSString *getImageStrUrl = [NSString stringWithFormat:@"%@",[self.thisPro.commodityImage objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc]init];
        photo.url = [NSURL URLWithString:getImageStrUrl];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 320, 200)];
        [imageView setImageWithURL:srcUrl];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = index;
    browser.photos = photos;
    [browser show];
}
#pragma mark - 推荐商品列表代理方法
-(void)proRecommendDidClick:(NSInteger)index
{
    Product *recPro= [self.thisPro.recommendProArray objectAtIndex:index];
    NSString *urlString=[NSString stringWithFormat:PRODETAIL_URL,serviceHost,recPro.productID];
    [self toRequestDataFromUrl:urlString typeTag:1 params:nil];
    [mainDelegate beginLoad];
}

-(void)hideShopView
{
    [UIView beginAnimations:nil context:nil];
    self.shopView.frame = CGRectMake(0, 10000, WindowWidth, WindowHeight);
    [UIView setAnimationDuration:1];
    [UIView commitAnimations];
    self.shopView.countTextField.text = @"1";
    self.shopView.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.thisPro.sellPrice];
    self.thisPro.buyCount = 1;
    [self endEdit];
}
-(void)shopViewDecrease
{
    if (self.thisPro.buyCount >1) {
        self.thisPro.buyCount--;
        [self.shopView setShoppingCartViewCount:self.thisPro.buyCount AndPrice:self.thisPro.sellPrice];
    }
}
-(void)shopViewIncrease
{
    self.thisPro.buyCount++;
    [self.shopView setShoppingCartViewCount:self.thisPro.buyCount AndPrice:self.thisPro.sellPrice];
}
-(void)shopViewConfirm
{
    if(self.thisPro.buyCount < 1)
    {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择商品数量" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    if (self.thisPro.isBuyNow)
    {
        if([self.thisPro.categoryID isEqualToString:@"66"] && self.thisPro.buyCount > 5)
        {
            //如果是活动的商品，一次只能购买5件
            UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:ACTIVITYTEXT delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [al show];
            return;
        }
        // 从立即购买来
        Product *pro=[[Product alloc]init];
        pro.productID=self.thisPro.ID;
        pro.count=self.thisPro.buyCount;
        pro.type=_type;
        pro.catID=self.catID;
        pro.sellPrice=self.thisPro.sellPrice;
        pro.attrValue=[self.thisPro.commodityImage objectAtIndex:0];
        pro.commodityName=self.thisPro.commodityName;
        NSMutableArray *array=[NSMutableArray arrayWithObjects:pro,nil];
       /* SettlementViewController *setView=[[SettlementViewController alloc]initWithNibName:@"SettlementViewController" bundle:nil];
        [setView setSettlementWithProducts:array SeettType:GoodsDetail];*/
        JiesuanViewController *setView=[[JiesuanViewController alloc]init];
        [setView setSettlementWithProducts:array SeettType:GoodsDetail];
        /*if([self.thisPro.categoryID isEqualToString:@"66"])
        {
            setView.isVIP = YES;
        }
        else
        {
            setView.isVIP = NO;
        }*/
        [self.navigationController pushViewController:setView animated:YES];
    }
    [self hideShopView];
}
-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonClick:(UIButton *)button
{
    //分享
    NSString *shareContent=[NSString stringWithFormat:@"%@  ￥%.2f",self.thisPro.commodityName,self.thisPro.sellPrice];
    self.shareView = [[ShareView alloc]initShareViewWith:@"掌上逛华联，随时“尚超市”" AndContent:shareContent AndImage:self.thisPro.shareImageURL];
    [self.view addSubview:self.shareView];
}
-(void)addToCartAction:(UIButton *)button
{
    //加入购物车动画效果
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    UIImageView *donghua = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    donghua.image = [UIImage imageNamed:@"Icon.png"];
    [transitionLayer addSublayer:donghua.layer];
    CGRect startRect = button.bounds;
    startRect.origin.x = startRect.size.width/2+startRect.origin.x-12;
    
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:startRect fromView:button];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    CGPoint toPoint = CGPointMake(self.shoppingcartButton.center.x+50, self.shoppingcartButton.center.y-30);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(self.shoppingcartButton.center.x,transitionLayer.position.y-300)];//弹跳的高度
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.4;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    [transitionLayer addAnimation:group forKey:@"opacity"];
    [self performSelector:@selector(addShopFinished:) withObject:transitionLayer afterDelay:0.4f];
}
//加入购物车 步骤2
- (void)addShopFinished:(CALayer*)transitionLayer{
    mainDelegate.countOfCart ++;
    NSString *countString = [NSString stringWithFormat:@"%d",mainDelegate.countOfCart];
    [self.leveyTabBarController addNumToCarList:countString];
    [self.tableView reloadData];
    [transitionLayer removeFromSuperlayer];
    transitionLayer.opacity = 0;
    for(CALayer *layer in [transitionLayer sublayers])
    {
        [layer removeFromSuperlayer];
    }
    [self.shoppingcartButton setShoppingCartNumWith:mainDelegate.countOfCart];
    [self setTabBarNum:0];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.4f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions =@[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.shoppingcartButton.redImageView.layer addAnimation:popAnimation forKey:nil];
    [self.shoppingcartButton.numLabel.layer addAnimation:popAnimation forKey:nil];
    
}
/**
 *点击收藏
 **/
-(void)collectAction:(UIButton *)button
{
    if ([self isAlreadyLogined]) {
        [self.bannerCell collectAnimation];
        self.thisPro.isCollect = YES;
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_type],@"type",[NSString stringWithFormat:@"%@",self.catID],@"categoryID",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",self.thisPro.ID,@"gid",nil];
        NSString *urlString = [NSString stringWithFormat:addShouCang,serviceHost];
        [self toRequestDataFromUrl:urlString typeTag:2 params:dict];
    } else {
        [self showNotLoginAlertView];
    }
}
-(void)toPlanAction
{
    if ([self isAlreadyLogined]) {
        self.thisPro.isPlan = YES;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:self.thisPro.ID forKey:@"planid"];
        [dict setObject:[self.thisPro.commodityImage objectAtIndex:0] forKey:@"urlimage"];
        [dict setObject:@"0" forKey:@"status"];
        [dict setObject:self.thisPro.commodityName forKey:@"planname"];
        [dict setObject:@"2" forKey:@"type"];
        [dict setObject:[self generateCompareTime] forKey:@"comparetime"];
        [dict setObject:[self generateRemindTime] forKey:@"remindtime"];
        [[DBManager sharedDatabase]insertintoShoppinglist:dict];
    } else {
        [self showNotLoginAlertView];
    }
}

-(void)BuyNow:(id)sender
{
    self.thisPro.isBuyNow = YES;
    if ([self isAlreadyLogined]) {
        self.thisPro.buyCount = 1;
        [self.shopView showShopViewWith:@"确认购买"];
        [self.shopView setShoppingCartViewCount:self.thisPro.buyCount AndPrice:self.thisPro.sellPrice];
        [UIView beginAnimations:nil context:nil];
        self.shopView.frame = CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight);
        [UIView setAnimationDuration:1];
        [UIView commitAnimations];
    } else {
        [self showNotLoginAlertView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)toRequestDataFromUrl:(NSString *)url typeTag:(int)tag params:(NSMutableDictionary *)dic{
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.delegate=self;
    hd.type=tag;
    hd.method=@selector(downloadComplete:);
    hd.failMethod = @selector(downloadFail);
    if (dic) {
        [hd getResultData:dic baseUrl:url];
    }else{
        [hd downloadFromUrl:url];
    }
    thisDownLoad = hd;
}
-(void)finishEdit:(UIButton *)button
{
    self.thisPro.buyCount = [self.shopView.countTextField.text intValue];
    self.shopView.totalPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.thisPro.buyCount*self.thisPro.sellPrice];
    [self endEdit];
}
-(void)cancelEdit:(UIButton *)button
{
    self.thisPro.buyCount = 1;
    [self.shopView setShoppingCartViewCount:self.thisPro.buyCount AndPrice:self.thisPro.sellPrice];
    [self endEdit];
}
#pragma mark - textfield methods
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(isIPhone5)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0, -90, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.view.frame=CGRectMake(0, -165, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}
-(void)setTabBarNum:(NSInteger)num
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_type],@"type",[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
    [dict setObject:self.thisPro.ID forKey:@"id"];
    [dict setObject:@"1" forKey:@"count"];
    if(_type != 0){
        [dict setObject:self.catID forKey:@"categoryID"];
    }
    else
    {
        [dict setObject:@"" forKey:@"categoryID"];
    }
    [dict setObject:[self.thisPro.commodityImage objectAtIndex:0] forKey:@"attrValue"];
    NSString *sellPriceString = [NSString stringWithFormat:@"%.2f",self.thisPro.sellPrice];
    [dict setObject:sellPriceString forKey:@"sellPrice"];
    [dict setObject:self.thisPro.commodityName forKey:@"commodityName"];
    [[DBManager sharedDatabase]insertIntoCarlist:dict];
}
-(void)endEdit
{
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
-(CGSize)heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit;
}
@end

