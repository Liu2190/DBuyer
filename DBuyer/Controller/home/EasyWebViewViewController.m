//
//  EasyWebViewViewController.m
//
//  Created by lugang on 8/26/13.
//  Copyright (c) 2013 lugang. All rights reserved.
//

#import "EasyWebViewViewController.h"
#import "NavigationBarView.h"
#import "ShareView.h"

#define ACTIV_LIST_TAG 1 //进入活动列表页面
#define PRODUCT_DETAIL_TAG 2//进入商品详情页面
@interface EasyWebViewViewController () <NavigationBarViewDelegate,UIActionSheetDelegate>
@property (nonatomic,retain)NSString *urlString;
@property (nonatomic,retain)NSString *titleName;
@property (nonatomic,assign)ShareView *shareView;
@property (nonatomic,assign)UIWebView *webView;
@end

@implementation EasyWebViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _buyUrl = [[NSString alloc]init];
        _name = [[NSString alloc]init];
        _shareString = [[NSString alloc]init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // navigationBar视图
    self.navigationController.navigationBarHidden = YES;
    NavigationBarView * navigationView = [NavigationBarView navigationBarView];
    [navigationView setLeftImage:[UIImage imageNamed:@"Image_HomeView_back"]
                      rightImage:[UIImage imageNamed:@"pro_share_image"]
                      titleImage:nil
                           title:@"尚鳞科技"];
    navigationView.delegate = self;
    [self.view addSubview:navigationView];

    
    if (!_buyUrl.length > 0) {
        
        _buyUrl = @"http://www.dbuyer.cn";
    }
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite];
    [activityIndicatorView setColor:[UIColor grayColor]];
    [activityIndicatorView setHidesWhenStopped:YES];
    [self.view addSubview : activityIndicatorView] ;

    NSURL *url =[NSURL URLWithString:_buyUrl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, [navigationView bottom], 320, WindowHeight-TabbarHeight-[navigationView bottom])];
    [self.view addSubview:self.webView];
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webView.scalesPageToFit =YES;
    self.webView.delegate = self;
    [self.webView loadRequest:request];
}
#pragma mark navigationBar 代理方法
- (void)navigationBarDidClickButton:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (buttonIndex == 1)
    {
        //分享
        self.shareView = [[ShareView alloc]initShareViewWith:self.shareString AndContent:_buyUrl AndImage:@"Icon.png"];
        [self.view addSubview:self.shareView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *schemeString = [request.URL scheme];
    NSString *schemeLower = [schemeString lowercaseString];//强制转换为小写；
    if ([schemeLower isEqualToString:@"promotions"]) {
        //进入活动列表页面
        NSString *string = request.URL.absoluteString;
        NSRange urlRange = [string rangeOfString:@":"];
        NSRange titleRange = [string rangeOfString:@"@"];
        NSRange urlABRange = NSMakeRange(urlRange.location+1, titleRange.location-urlRange.location-1);
        NSString *urlAB = [request.URL.absoluteString substringWithRange:urlABRange];
        self.urlString = [NSString stringWithFormat:@"%@%@",serviceHost,urlAB];
        self.titleName = [[request.URL.absoluteString substringFromIndex:titleRange.location + 1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        HttpDownload *hd = [[HttpDownload alloc]init];
        hd.delegate = self;
        hd.type = ACTIV_LIST_TAG;
        hd.method = @selector(downloadComplete:);
        [hd downloadFromUrl:self.urlString];
    }
    if([schemeLower isEqualToString:@"productdetail"])
    {
        //进入商品详情页面
        NSString *urlString = request.URL.absoluteString;
        NSRange range = [urlString rangeOfString:@":"];
        NSString *productID = [request.URL.absoluteString substringFromIndex:range.location + 1];
        HttpDownload *hd = [[HttpDownload alloc]init];
        hd.delegate = self;
        hd.method = @selector(downloadComplete:);
        hd.type = PRODUCT_DETAIL_TAG;
        NSString *proUrlString = [NSString stringWithFormat:PRODETAIL_URL,serviceHost,productID];
        [hd downloadFromUrl:proUrlString];
    }
    return YES;
}

-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        if(hd.type == ACTIV_LIST_TAG)
        {
            BargainGoodsViewController *barVC= [[BargainGoodsViewController alloc]initWithNibName:@"BargainGoodsViewController" bundle:nil];
            barVC.listDic = dict;
            barVC.typeID = @"0";
            barVC.source = BannerProList;
            barVC.listUrlString = self.urlString;
            barVC.catName = self.titleName;//banner图跳转到商品列表时，列表名称由服务器返回；
            barVC.page_count = [[dict objectForKey:@"page_count"] intValue];
            barVC.current_page = [[dict objectForKey:@"current_page"] intValue];
            [self.navigationController pushViewController:barVC animated:YES];
        }
        if(hd.type == PRODUCT_DETAIL_TAG)
        {
            if([[dict objectForKey:@"status"] intValue]==0)
            {
                if ([[[dict objectForKey:@"mapinfo"] objectForKey:@"status"] integerValue] != 0)
                {
                    [self showError:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"mapinfo"] objectForKey:@"msg"]]];
                    return;
                }
                ProductdetailsViewController *so=[[ProductdetailsViewController alloc] initWithNibName:@"ProductdetailsViewController" bundle:nil];
                so.type = 0;
                so.detailDict = dict;
                [self.navigationController pushViewController:so animated:YES];
            }
        }
    }
}
@end
