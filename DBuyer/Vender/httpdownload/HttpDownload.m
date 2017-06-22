//
//  HttpDownload.m
//  DBuyer
//
//  Createdr by liuxiaodan on 13-10-14.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "HttpDownload.h"
#import "UIDevice+Resolutions.h"

@interface HttpDownload ()

@property (nonatomic, retain) NSString * url;

@end

@implementation HttpDownload
@synthesize downloadData,method,type,delegate;
-(id)init{
    if(self = [super init]) {
        downloadData = [[NSMutableData alloc]init];
    }
    return self;
}
#pragma mark 配置url
-(NSString *)appendParamsFor:(NSString *)url{
    
    int flag = 0;
    for (int i = 0; i<url.length; i++) {
        char c = [url characterAtIndex:i];
        if (c == '?') {
            flag = 1;
        }
    }
    // 所有接口添加stamp, verify, versionNum, os_code, size_code参数（时间戳, 验证码, 版本号, 平台ID, 像素尺寸）
    NSString *stamp = [TimeStamp timeStamp];
    NSString *verify = [MD5 md5];
    
    // versionNum
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"versionNum"];
    NSString *os_code =  @"2";
    NSString *size_code = [NSString stringWithFormat:@"%d",[UIDevice currentResolution]];
    
    NSString *newUrl = nil;
    if (flag == 1)
        newUrl = [url stringByAppendingString:[NSString stringWithFormat:@"&stamp=%@&verify=%@&versionNum=%@&os_code=%@&size_code=%@",stamp,verify,version,os_code,size_code]];
    else
        newUrl = [url stringByAppendingString:[NSString stringWithFormat:@"?stamp=%@&verify=%@&versionNum=%@&os_code=%@&size_code=%@",stamp,verify,version,os_code,size_code]];
    
    return newUrl;
}

#pragma mark 根据url请求数据
-(void)downloadFromUrl:(NSString *)url {
    url = [self appendParamsFor:url];
    if (httpConnection) {
        httpConnection=nil;
    }
    
    NSURL *newUrl=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp)]];
    NSURLRequest *request=[NSURLRequest requestWithURL:newUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    httpConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection 连接服务器失败方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[UIApplication sharedApplication].keyWindow setUserInteractionEnabled:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self handleError:@"网络连接异常，请稍后重试!"];
}

#pragma mark NSURLConnection 接收到服务器请求
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if([response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *newResponse=(NSHTTPURLResponse *)response;
        if ([newResponse statusCode]/100 == 4) {
            [self handleError:@"网络连接异常，请稍后重试!"];
        }
    }
    
    [downloadData setLength:0];
}

#pragma mark NSURLConnection 接收数据方法
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [downloadData appendData:data];
}

#pragma mark NSURLConnection 接收完成方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
            if(self.delegate && self.method)
                [self.delegate performSelector:self.method withObject:self];
}

#pragma mark NSURLConnection 网络请求错误处理
- (void)handleError:(NSString *)error {
    if (self.delegate && self.failMethod) {
        [self.delegate performSelector:self.failMethod withObject:self];
    }
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:error
                                                        delegate:self.delegate
                                               cancelButtonTitle:@"我知道了"
                                               otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark NSURLConnection 取消网络连接
- (void)ConnectionCanceled {
    if (httpConnection) {
        [httpConnection cancel];
        downloadData = nil;
        httpConnection = nil;
    }
}

-(void)getResultData:(NSMutableDictionary *)params baseUrl:(NSString *)baseUrl {
    NSString *postUrl = [self createPostURL:params];
    NSMutableURLRequest *theRequst=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:baseUrl]
                                                                cachePolicy:NSURLCacheStorageAllowed
                                                            timeoutInterval:10.0];
    
    [theRequst setHTTPMethod:@"POST"];
    [theRequst setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [theRequst setHTTPBody:[postUrl dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp)]];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:theRequst delegate:self] ;
    httpConnection = con;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.delegate && self.failMethod) {
        [self.delegate performSelector:self.failMethod withObject:self];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 第三方
-(void)downloadFromUrlWithASI:(NSString *)url{
    NSURL *newUrl=[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:newUrl];
    request.delegate=self;
    [request startAsynchronous];//启动异步下载;
}

-(void)downloadFromUrlWithASI:(NSString *)url dict:(NSMutableDictionary *)dict{
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate=self;
    NSStringEncoding enc=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [request setStringEncoding:enc ];
    for(NSString * key  in [dict allKeys]){
        
        id object=[dict objectForKey:key];
        [request setPostValue:object forKey:key];
    }
    [request startSynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [downloadData setLength:0];
    [downloadData appendData:request.rawResponseData];
    if([self.delegate respondsToSelector:self.method]) {
        [self.delegate performSelector:self.method withObject:self];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    
    if([self.delegate respondsToSelector:self.failMethod]){
        [self.delegate performSelector:self.failMethod withObject:self];
    }
}

-(NSString *)createPostURL:(NSMutableDictionary *)params {
    NSString *postString=@"";
    for(NSString *key in [params allKeys]) {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    
    if([postString length]>1) {
        postString=[postString substringToIndex:[postString length]-1];
    }
    
    return postString;
}
@end
