//
//  Integral.m
//  DBuyer
//
//  Created by lu gang on 13-11-21.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "Integral.h"
#import "LXD.h"
#import "RecommendScrollView.h"
#import "Product.h"

#define NAVIGATIONBAR_HEIGHT   [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending ? 44 : 44 + 22   // 导航条的高度
#define VIEW_BACKGROUND_COLOR   [UIColor colorWithRed:0.937 green:0.929 blue:0.851 alpha:1]                                     // VIEW背景
#define HORIZONTAL_VIEW_FRAME   CGRectMake(9,[[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending ? 44 + (26+116)/2-3: 44 + 22+13 + (26+116)/2-3, 305, 10)                                     // 圆角Frame
#define RADIUS1 CGRectMake(9,[[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending ? 44+13: 44 + 22+13, 305, 58)                                                               // 圆角1
#define RADIUS2 CGRectMake(9, [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending ? 44+13+58: 44 +14+13+58, 305, 58)                                                          // 圆角2
#define MYPOINTS_TEXT_COLOR [UIColor colorWithRed:0.039 green:0.376 blue:0.302 alpha:1]                                         // 我的积分文字颜色
#define MYPOINTS_TEXT_FRAME CGRectMake((28+30+122)/2, (26)/2, 110, 40)                                                          // 我的积分Frame
#define MYPOINTS_LABLE_TEXT_FRAME CGRectMake((28)/2, (26)/2, 110, 30)                                                           // 我的积分LableFrame
#define HORIZONTALVIEW_FRAME  CGRectMake(lineImgView.frame.origin.x, lineImgView.frame.origin.y, 305, 1)                        // 中间横线Frame
#define LEFTCONTENT_LABLE_FRAME CGRectMake((28)/2, (41)/2, 90, 30)                                                              // 左侧内容的Frame
#define LEFTCONTENT_LABLE_TEXT_COLOR  [UIColor colorWithRed:0.514 green:0.514 blue:0.514 alpha:1]                               // 左侧内容的文字颜色
#define RIGHTCONTENT_LABLE_FRAME    CGRectMake((28+90+145)/2, (41)/2, 130, 30)                                                  // 右侧内容的Frame
#define RIGHTCONTENT_LABLE_TEXT_COLOR   [UIColor colorWithRed:0.514 green:0.514 blue:0.514 alpha:1]                             // 右侧内容的文字颜色
#define POINTSVALUE_FRAME           CGRectMake((28+90+145+220)/2, (41)/2, 130, 30)                                              // 积分frame
#define POINTSVALUE_TEXT_COLOR      [UIColor colorWithRed:0.792 green:0.196 blue:0.220 alpha:1]                                 // 积分文字颜色
#define CHANGE_BUY_LABLE_FRAME  CGRectMake(14, radius1.frame.origin.y + radius1.frame.size.height + 90, 90, 50)                // 换购Lable的Frame
#define CHANGE_BUY_LABLE_TEXT_COLOR [UIColor colorWithRed:0.247 green:0.247 blue:0.247 alpha:1]                                 // 换购文字颜色


@interface Integral () <RecommendScrollViewDelegate>
@property (nonatomic, retain) HttpDownload * thisDownload;
@property (nonatomic, retain) RecommendScrollView * recommendView;
@property (nonatomic, retain) NSMutableArray * recommendProductList;
@end

@implementation Integral
@synthesize jifen;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.recommendProductList = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadContentView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HttpDownload *hd=[[HttpDownload alloc]init];
    hd.type=20;
    self.thisDownload=hd;
    hd.delegate=self;
    hd.method=@selector(downloadComplete:);
    [hd downloadFromUrl:[NSString stringWithFormat:@"%@interface/search/queryHotKeyWord",serviceHost]];
    [[self mainDelegate] beginLoad];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.recommendProductList removeAllObjects];
}
#pragma mark - LOAD_VIEW
- (void)loadContentView
{
    // 设置NavigationBar
    [self setNavigationBarWithContent:@"积分详情" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    
    // 设置圆角View
    UIView *radius = [self loadIntegralRadiusViewWithFrame:RADIUS1];
    [self.view addSubview:radius];
    UIView *radius1 = [self loadIntegralRadiusViewWithFrame:RADIUS2];
    [self.view addSubview:radius1];
    
    // 设置背景
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    
    // 我的积分Lable
    LXD *myPointsLable=[[LXD alloc]initWithText:@"我的积分" font:18 textAlight:NSTextAlignmentLeft frame:MYPOINTS_LABLE_TEXT_FRAME backColor:[UIColor clearColor] textColor:[UIColor darkGrayColor]];
    myPointsLable.font=[UIFont fontWithName:@"Helvetica-Bold" size:(14)];
    [radius addSubview:myPointsLable];
    
    // 我的积分
    LXD *myPoints = [[LXD alloc] initWithText:[NSString stringWithFormat:@"%d", [jifen intValue]] font:24 textAlight:NSTextAlignmentCenter frame:MYPOINTS_TEXT_FRAME backColor:[UIColor clearColor] textColor:MYPOINTS_TEXT_COLOR];
    myPoints.font=[UIFont fontWithName:@"Helvetica-Bold" size:(20)];
    [radius addSubview:myPoints];
    
    // 设置textField中间的横线view
    UIView *horizontalView = [[UIView alloc] initWithFrame:HORIZONTAL_VIEW_FRAME];
    [self.view addSubview:horizontalView];
    horizontalView.backgroundColor = [UIColor whiteColor];
    UIImageView *lineImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontal_line"]];
    lineImgView.frame = HORIZONTALVIEW_FRAME;
    [horizontalView addSubview:lineImgView];
    
    // 左侧内容
    
    LXD *leftContentLable = [[LXD alloc] initWithText:@"500积分＝￥4" font:18 textAlight:NSTextAlignmentLeft frame:LEFTCONTENT_LABLE_FRAME backColor:[UIColor clearColor] textColor:LEFTCONTENT_LABLE_TEXT_COLOR];
    
    leftContentLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:(14)];
    [radius1 addSubview:leftContentLable];
    
    // 右侧内容
    LXD *rightContentLable =[[LXD alloc]initWithText:@"您的所持积分=￥" font:18 textAlight:NSTextAlignmentLeft frame:RIGHTCONTENT_LABLE_FRAME backColor:[UIColor clearColor] textColor:RIGHTCONTENT_LABLE_TEXT_COLOR];
    rightContentLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:(14)];
    [radius1 addSubview:rightContentLable];
    
    // 积分数值
    double pointV = [jifen intValue] * 0.008;
    LXD *pointsValue =[[LXD alloc]initWithText:[NSString stringWithFormat:@"%0.2f", pointV] font:18 textAlight:NSTextAlignmentLeft frame:POINTSVALUE_FRAME backColor:[UIColor clearColor] textColor:POINTSVALUE_TEXT_COLOR];
    pointsValue.font=[UIFont fontWithName:@"Helvetica-Bold" size:(18)];
    [radius1 addSubview:pointsValue];
    
    // 添加水平拖动浏览视图
    self.recommendView = [[RecommendScrollView alloc] initWithArray:nil title:@"0元换购" startPoint:CGPointMake(0, 280)];
    self.recommendView.RSdelegate = self;
    [self.view addSubview:self.recommendView];
}
#pragma mark - 水平拖动视图代理方法
- (void)RecommendViewDidClicked:(NSUInteger)index
{
    //进入商品详情页面
    Product *thisPro = [self.recommendProductList objectAtIndex:index];
    NSString *str = [NSString stringWithFormat:PRODETAIL_URL, serviceHost, thisPro.productID];
    HttpDownload *hd = [[HttpDownload alloc] init];
    self.thisDownload = hd;
    [[self mainDelegate] beginLoad];
    hd.delegate = self;
    hd.method = @selector(downloadComplete:);
    [hd downloadFromUrl:str];
    hd.type = 1200;
    [[self mainDelegate] beginLoad];
}
#pragma mark - 下载数据
-(void)downloadComplete:(HttpDownload *)hd{
    [[self mainDelegate] endLoad];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        if(hd.type==1200){//
            if ([[[dict objectForKey:@"mapinfo"]objectForKey:@"status"] integerValue] == 1) {
                
                NSString *str = [[dict objectForKey:@"mapinfo"]objectForKey:@"msg"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:str delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = 2;
                [alert show];
                return;
            }
            
            if([[dict objectForKey:@"status"] intValue]==0){
                
                if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0) {
                    
                    [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                    return;
                }
                ProductdetailsViewController *so=[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil];
                so.detailDict = dict;
                [self.navigationController pushViewController:so animated:YES];
            }
        }
        if(hd.type==20){//推荐礼包和推荐商品
            if([[dict objectForKey:@"status"] intValue]==0){
                [self.recommendProductList removeAllObjects];
                NSArray * returnGood = [NSArray arrayWithArray:[dict objectForKey:@"returnlistGood"]];
                //                [returnGood addObjectsFromArray:[dict objectForKey:@"returnlistGood"]];
                //                [returnBox addObjectsFromArray:[dict objectForKey:@"returnlistbBox"]];
                //                NSArray *array1=[dict objectForKey:@"recommendCommodity"];
                /*
                 {
                 msg = "\U67e5\U8be2\U5230\U6570\U636e";
                 returnlistGood =     (
                 {
                 attrValue = "";
                 descrip
                 tion = "\U5bcc\U6cfd\U5546\U5e97\U6241\U6843\U4ec1\U7247120g/\U888b";
                 findType = 0;
                 goodsID = 872386bc2ceb4d7098e3cc8b7927036c;
                 price = "";
                 title = "\U5bcc\U6cfd\U5546\U5e97\U6241\U6843\U4ec1\U7247120g/\U888b";
                 },
                 {
                 attrValue = "";
                 description = "\U5bcc\U6cfd\U5546\U5e97\U6574\U7c92\U6241\U6843\U4ec1200g/\U888b";
                 findType = 0;
                 goodsID = dbef4e5cc33f4908b8f66514a70d2cf9;
                 price = "";
                 title = "\U5bcc\U6cfd\U5546\U5e97\U6574\U7c92\U6241\U6843\U4ec1200g/\U888b";
                 },
                 {
                 attrValue = "";
                 description = "\U5bcc\U6cfd\U5546\U5e97\U8170\U679c120g/\U888b";
                 findType = 0;
                 goodsID = f9b6fc77d0e245989e8b3cacc1233cc3;
                 price = "";
                 title = "\U5bcc\U6cfd\U5546\U5e97\U8170\U679c120g/\U888b";
                 },
                 {
                 attrValue = "";
                 description = "\U60c5\U4fa3\U793c\U5305";
                 findType = 1;
                 goodsID = 3bdaf9f3df79432db4ee53d48e949177;
                 price = "";
                 title = "\U60c5\U4fa3\U793c\U5305";
                 },
                 {
                 attrValue = "";
                 description = "\U6625\U8282\U5927\U793c\U5305";
                 findType = 1;
                 goodsID = 7e12e189f06043a3b3c5f41cabe92911;
                 price = "";
                 title = "\U6625\U8282\U5927\U793c\U5305";
                 },
                 {
                 attrValue = "";
                 description = "\U4e94\U4e00\U5927\U793c\U5305";
                 findType = 1;
                 goodsID = 70d6531d7c3042fd8ee930be12649f8a;
                 price = "";
                 title = "\U4e94\U4e00\U5927\U793c\U5305";
                 }
                 );
                 returnlistbBox =     (
                 {
                 attrValue = "http://www.dbuyer.cn/image18/WDZA270x170.jpg";
                 boxPrice = "679.2";
                 id = 70191b0c95f44a0da181784e1a9d0cbe;
                 totalPrice = 849;
                 },
                 {
                 attrValue = "http://www.dbuyer.cn/image18/THJX270x170.jpg";
                 boxPrice = "802.4";
                 id = 476fda8881064e2c9074635f76c80860;
                 totalPrice = 1003;
                 },
                 {
                 attrValue = "http://www.dbuyer.cn/image18/NNGZ270x170.jpg";
                 boxPrice = "319.2";
                 id = d2d0fe5b9fc04abea15671185edb9651;
                 totalPrice = 399;
                 }
                 );
                 status = 0;
                 }
                 */
                for(int i=0;i<returnGood.count;i++){
                    //商品
                    Product * product = [[Product alloc] init];
                    
                    product.productID = [returnGood[i] objectForKey:@"goodsID"];
                    product.attrValue = [returnGood[i] objectForKey:@"attrValue"];
                    product.commodityName = [returnGood[i] objectForKey:@"title"];
                    product.sellPrice = [[returnGood[i] objectForKey:@"price"] floatValue];
                    //                    product.marketPrice = [[returnGood[i] objectForKey:@"marketPrice"] floatValue];
                    //                    product.keyWord = [returnGood[i] objectForKey:@"keyWord"];
                    [self.recommendProductList addObject:product];
                }
                // 给收藏为空视图传值
                [self.recommendView showWithProducts:self.recommendProductList];
                
            }
        }
    }
}

#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [[self mainDelegate] endLoad];
    [self.thisDownload ConnectionCanceled];
}
#pragma mark 设置返回按钮
-(void)leftButtonClick:(UIButton  *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)pushDetail:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 圆角View - 用于UITextField背景
- (UIView *)loadIntegralRadiusViewWithFrame:(CGRect)frame
{
    UIView *radiusView = [[UIView alloc] initWithFrame:frame];
    radiusView.backgroundColor = [UIColor whiteColor];
    radiusView.layer.masksToBounds = YES;
    radiusView.layer.cornerRadius = 6.0;
    radiusView.layer.borderWidth = 1.0;
    radiusView.layer.borderColor = [[UIColor whiteColor] CGColor];
    return radiusView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
