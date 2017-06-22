//
//  ScanWebViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 13-11-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ScanWebViewController.h"
#import "StartPoint.h"
@interface ScanWebViewController ()

@end

@implementation ScanWebViewController
@synthesize searchText;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self setNavigationBarWithContent:@"尚超市BHG" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, [StartPoint startPoint], 320, self.view.frame.size.height-[StartPoint startPoint]-TabbarHeight)];
    webView.backgroundColor=[UIColor clearColor];
    webView.delegate=self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",searchText]]];
    [self.view addSubview: webView];
    [webView loadRequest:request];
    mainDelegate = [self mainDelegate];
}
-(void)leftButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void )webViewDidStartLoad:(UIWebView  *)webView{  //网页开始加载的时候调用
    [mainDelegate beginLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad{
    [mainDelegate endLoad];
    [thisDownLoad ConnectionCanceled];
}
- (void )webViewDidFinishLoad:(UIWebView  *)webView {// 网页加载完成的时候调用
    [mainDelegate endLoad];
}
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error {
    //网页加载错误的时候
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
