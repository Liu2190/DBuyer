
//
//  TBill99PayController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-28.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//


#import "TBill99PayController.h"
#import "TUtilities.h"

@implementation TBill99PayController

- (id)initWithHtmlString:(NSString*)htmlString {
    self = [super init];
    _htmlString = htmlString;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TUtilities getInstance]popTarget:self.mainWebView status:@"加载中..."];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationSetStatusBar"object:@"0"];
}

- (void)loadView {
    self.mainWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainWebView.delegate = self;
    self.mainWebView.scalesPageToFit = YES;
    // [self.mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    [self.mainWebView loadHTMLString:_htmlString baseURL:nil];
    self.view = self.mainWebView;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationSetStatusBar"object:@"1"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString* rurl=[[request URL] absoluteString];
    NSArray *theArray = [rurl componentsSeparatedByString:@"?"];
    NSString *theString = [theArray lastObject];
    if (theArray.count>0 && [theString hasPrefix:@"type=a"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[TUtilities getInstance]dismiss];
    
    [super webViewDidFinishLoad:webView];
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%@",@"document.getElementById('cancel_btn').onclick=",@"function() {location.href='#:?type=a';}"]];
    
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *lHtml1 = [self.mainWebView stringByEvaluatingJavaScriptFromString:lJs];
    NSLog(@"%@",lHtml1);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[TUtilities getInstance]popMessageError:@"加载失败" target:webView delayTime:1.0];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {}

@end