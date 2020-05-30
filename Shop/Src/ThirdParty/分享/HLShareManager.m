//
//  HLShareManager.m
//  Telegraph
//
//  Created by 黄磊 on 2016/12/8.
//
//

#import "HLShareManager.h"
//#import "SBAFNetWork.h"

//#import "HQOpenPlat.h"

@implementation HLShareManager
{
    responseBlock _respBlock;
    HLSharePlatformType _currentType;
    NSString *_wbtoken;
    NSString *_wbCurrentUserID;
}
+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    static HLShareManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[HLShareManager alloc] init];
        [WXApi registerApp:KWXAppId enableMTA:NO];
        [[TencentOAuth alloc] initWithAppId:KQQAppId andDelegate:nil];
        [WeiboSDK enableDebugMode:NO];
        [WeiboSDK registerApp:KSinaAppKey];
    });
    return instance;
}

-(BOOL)handleOpenURL:(NSURL *)url
{
//    if ([url.scheme containsString:@"tencent"]||[url.scheme containsString:@"QQ"]||[url.scheme containsString:@"wx"]) {
//        [HQOpenPlat handleOpenURL:url];
//    }
    
    if ([url.scheme containsString:@"tencent"]||[url.scheme containsString:@"QQ"]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }
//    else if ([url.scheme containsString:@"wx"])
//    {
//        return [WXApi handleOpenURL:url delegate:self];
//    }else
     else if ([url.scheme containsString:@"wb"])
    {
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    return YES;
}

-(void)ShareWithPlatform:(HLSharePlatformType)type LinkURL:(NSString *)url Title:(NSString *)title Description:(NSString *)desc Image:(UIImage *)image responseBlock:(responseBlock)responseBlock
{
    
    UIImage *newImage=[self handleImageWithImage:image];
    _respBlock=responseBlock;
    _currentType=type;
    
    switch (type) {
        case HLSharePlatformType_WeiXinFriends:
        {
            //判断微信是否安装
            if ((type==HLSharePlatformType_WeiXinTimeLine||type==HLSharePlatformType_WeiXinFriends)&&!([WXApi isWXAppInstalled]||[WXApi isWXAppSupportApi])) {
                [MBProgressHUD showError:@"请先下载最新版微信！"];
                return;
            }
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = url;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = title;
            message.description = desc;
            message.mediaObject = ext;
            message.messageExt = nil;
            message.messageAction = nil;
            message.mediaTagName = @"";
            [message setThumbImage:newImage];
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc]init];
            req.bText=NO;
            req.scene=WXSceneSession;
            req.message=message;
            
            [WXApi sendReq:req];
        }
            break;
        case HLSharePlatformType_WeiXinTimeLine:
        {
            //判断微信是否安装
            if ((type==HLSharePlatformType_WeiXinTimeLine||type==HLSharePlatformType_WeiXinFriends)&&!([WXApi isWXAppInstalled]||[WXApi isWXAppSupportApi])) {
                [MBProgressHUD showError:@"请先下载最新版微信！"];
                return;
            }
            
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = url;
            
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = title;
            message.description = desc;
            message.mediaObject = ext;
            message.messageExt = nil;
            message.messageAction = nil;
            message.mediaTagName = @"";
            [message setThumbImage:newImage];
            
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc]init];
            req.bText=NO;
            req.scene=WXSceneTimeline;
            req.message=message;
            
            [WXApi sendReq:req];
        }
            break;
        case HLSharePlatformType_QQSpace:
        {
            //判断QQ是否安装
            if (type==HLSharePlatformType_QQSpace && !([QQApiInterface isQQInstalled]&&[QQApiInterface isQQSupportApi])) {
                [MBProgressHUD showError:@"请先下载最新版QQ！"];
                return;
            }
            
            NSURL *url1=[NSURL URLWithString:url];
            NSData *imageData=UIImagePNGRepresentation(newImage);
            QQApiNewsObject *imageObject=[QQApiNewsObject objectWithURL:url1 title:title description:desc previewImageData:imageData];
            SendMessageToQQReq *req=[SendMessageToQQReq reqWithContent:imageObject];
            QQApiSendResultCode sent=[QQApiInterface sendReq:req];
        }
            break;
        case HLSharePlatformType_Sina:
        {
            WBAuthorizeRequest *authRequest =[WBAuthorizeRequest request];
            authRequest.redirectURI=@"https://api.weibo.com/oauth2/default.html";
            authRequest.scope=@"all";
            
            WBMessageObject *message = [WBMessageObject message];
            message.text=[desc stringByAppendingString:url];
            WBImageObject *imageObject =[WBImageObject object];
            imageObject.imageData=UIImagePNGRepresentation(image);
            message.imageObject=imageObject;
            
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest  access_token:_wbtoken];
//            NSLog(@"%d",[WeiboSDK openWeiboApp]);
            [WeiboSDK sendRequest:request];
        }
            break;
        default:
            break;
    }
}

////分享成功后给服务返回分享信息，用于服务器统计分享的数据
//-(void)shareSuccessWithChannel:(NSString *)channel {
//    NSDictionary *param=@{
//                          @"user_id":userModel.idx,
//                          @"system":@"1",
//                          @"version":[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
//                          @"channel":channel
//                          };
//    
//    [SBAFNetWork POST:@"task/sharesuccess" baseURL:DFC_Base_Url params:param success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } fail:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//}

- (UIImage *)handleImageWithImage:(UIImage *)image {
    // 压缩图片data大小
    NSData *newImageData = UIImageJPEGRepresentation(image, 0.1);
    UIImage *newImage = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    float height = image.size.height * (200 / image.size.width);
    CGSize newSize = CGSizeMake(200, height);
    UIGraphicsBeginImageContext(newSize);
    [newImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* endImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return endImage;
}

#define mark delegate Response

//-(void)onResp:(id)resp
//{
//    if ([resp isKindOfClass:[QQBaseResp class]])
//    {
//        SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
//        if ([sendResp.result isEqualToString:@"0"]) {
//
//            _respBlock(resp,YES,@"QQ分享成功!");
////            [self shareSuccessWithChannel:[NSString stringWithFormat:@"%d",_currentType]];
//        }
//        else
//        {
//            _respBlock(resp,NO,@"QQ分享失败!");
//        }
//    }else if ([resp isKindOfClass:[BaseResp class]])
//    {
//        BaseResp *response=(BaseResp *)resp;
//        switch (response.errCode) {
//            case WXSuccess:
//            {
//                _respBlock(resp,YES,@"微信分享成功!");
////                [self shareSuccessWithChannel:[NSString stringWithFormat:@"%d",_currentType]];
//            }
//                break;
//            default:
//            {
//                _respBlock(resp,NO,@"微信分享失败!");
//            }
//                break;
//        }
//    }
//}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{

    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode==0) {
            _respBlock(response,YES,@"新浪微博分享成功!");
//            [self shareSuccessWithChannel:[NSString stringWithFormat:@"%d",_currentType]];
        }
        else
        {
            _respBlock(response,NO,@"新浪微博分享失败!");
        }
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            _wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            _wbCurrentUserID = userID;
        }
    }
}


@end
