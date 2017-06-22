//
//  ShareView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShareView.h"
@interface ShareView()<UIActionSheetDelegate>
@property (nonatomic,retain)NSString *shareString;
@property (nonatomic,retain)NSString *imageName;
@property (nonatomic,retain)NSString *titleString;
@end
@implementation ShareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(id)initShareViewWith:(NSString *)thisTitleString AndContent:(NSString *)thisShareString AndImage:(NSString *)thisImageName;
{
    if ((self=[super initWithFrame:CGRectMake(0, 0, WindowWidth, WindowHeight)]))
    {
        self.backgroundColor = [UIColor clearColor];
        self.shareString = [[NSString alloc]initWithString:thisShareString];
        self.imageName = [[NSString alloc]initWithString:thisImageName];
        self.titleString = [[NSString alloc]initWithString:thisTitleString];
        UIActionSheet *ac=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到新浪微博",@"分享给微信好友",@"分享到微信朋友圈",nil];
        ac.actionSheetStyle=UIBarStyleDefault;
        [ac showInView:[[UIApplication sharedApplication]keyWindow]];
    }
    return self;
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    self.hidden = YES;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.hidden = YES;
    if(buttonIndex==0)
    {
        AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.urlMark=SINA;
        [self sendWeiboContent:nil text:nil];
    }
    else if (buttonIndex==1)
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.urlMark = WECHAT;
        [self shareToWechat:nil text:nil toScene:WXSceneSession];
        
    }
    else if (buttonIndex==2)
    {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.urlMark = WECHAT;
        [self shareToWechat:nil text:nil toScene:WXSceneTimeline];
    }
}
-(void)shareToWechat :(NSString *)imageurl text:(NSString *)name1 toScene:(int)scene
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        if([self.imageName hasPrefix:@"http:"])
        {
            //网络图片
            UIImageView *temp=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            [temp setImageWithURL:[NSURL URLWithString:self.imageName]];
            UIImage *thumbImg = [self imageWithImageSimple:temp.image scaledToSize:CGSizeMake(80, 80)];
            [message setThumbImage:thumbImg];
        }
        else
        {
            //本地图片
            UIImageView *temp=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
            temp.image = [UIImage imageNamed:self.imageName];
            UIImage *thumbImg = [self imageWithImageSimple:temp.image scaledToSize:CGSizeMake(80, 80)];
            [message setThumbImage:thumbImg];
        }
        WXAppExtendObject *myObject = [WXAppExtendObject object];
        if (scene == WXSceneTimeline)
        {
            //朋友圈
            if([self.shareString hasPrefix:@"http:"])
            {
                myObject.url = self.shareString;
            }
            else{
                myObject.url = @"http://dbuyer.cn/downloads";
            }
            message.title = [NSString stringWithFormat:@"%@  %@",self.titleString,self.shareString];
        }
        else
        {
            //好友
            message.title = self.titleString;
            message.description = self.shareString;
        }
        myObject.extInfo = @"尚鳞科技";
        myObject.fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://dbuyer.cn/downloads"]];
        message.mediaObject = myObject;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.scene = scene;
        req.message = message;
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"" message:@"没有安装微信" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alView show];
    }
}
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)sendWeiboContent:(NSData *)imageData text:(NSString *)name
{
    WBImageObject *pageObject = [ WBImageObject object ];
    UIImageView *temp1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    if([self.imageName hasPrefix:@"http:"])
    {
        //网络图片
        [temp1 setImageWithURL:[NSURL URLWithString:self.imageName]];
    }
    else
    {
        //本地图片
        temp1.image = [UIImage imageNamed:self.imageName];
    }
    UIImage *temp=temp1.image;
    NSData *data;
    if (UIImagePNGRepresentation(temp) == nil) {
        data = UIImageJPEGRepresentation(temp, 1);
    } else {
        data = UIImagePNGRepresentation(temp);
    }
    pageObject.imageData = data;
    WBMessageObject *message = [WBMessageObject  message];
    message.text =[NSString stringWithFormat:@"%@ %@",self.titleString,self.shareString];
    message.imageObject = pageObject;
    WBSendMessageToWeiboRequest *req = [[WBSendMessageToWeiboRequest alloc ] init ] ;
    req.message = message;
    [ WeiboSDK sendRequest:req];
}

@end
