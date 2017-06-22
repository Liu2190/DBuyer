//
//  PictureUpload.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PictureUpload.h"
@interface PictureUpload()
{
    NSDictionary *resultDict;
}

@end
@implementation PictureUpload
-(void)uploadPictureWithDictionary:(NSDictionary *)fileDict WithURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSArray *filePathValues = [fileDict objectForKey:@"filePathValues"];
    NSArray *filePathKeys = [fileDict objectForKey:@"filePathKeys"];
    NSArray *fileNameValues = [fileDict objectForKey:@"fileNameValues"];
    NSArray *fileNameKeys = [fileDict objectForKey:@"fileNameKeys"];
    NSStringEncoding enc=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingMacChineseSimp);
    [request setStringEncoding:enc];
    for(int i = 0; i < [fileNameKeys count];i++)
    {
        [request setFile:[filePathValues objectAtIndex:i] forKey:[filePathKeys objectAtIndex:i]];
        [request setPostValue:[fileNameValues objectAtIndex:i] forKey:[fileNameKeys objectAtIndex:i]];
    }
    [request buildPostBody];
    [request setDelegate:self];
    [request setTimeOutSeconds:50];
    [request startSynchronous];
    [request setCompletionBlock:^{
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dict %@",dict);
    }];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSDictionary *requestDictionary = [request userInfo];
    NSLog(@"%@",requestDictionary);
    resultDict = [[NSDictionary alloc]initWithDictionary: requestDictionary];
    [self dataFromNet];
}
-(NSDictionary *)dataFromNet
{
    return resultDict;
}
-(void)requestFailed:(ASIHTTPRequest *)request{

}
@end
