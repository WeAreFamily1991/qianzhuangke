//
//  HLShareManager.h
//  Telegraph
//
//  Created by 黄磊 on 2016/12/8.
//
//

                               ///////////////使用说明///////////////////

//1.在 [application: didFinishLaunchingWithOptions:] 方法中调用 [RegisterQQWithAppId: andWeChatWithAppId: andSinaWithAppKey withBool:] ,填写对应的appid

//2.在 [application: openURL: options:] 、[application handleOpenURL:]、[application:openURL:sourceApplication: annotation:]方法中调用[handleOpenURL:]

//3.在需要分享的地方导入本类，调用三种分享方法的一种，分享成功后的回调在每个方法的Block里面，自行判断

//4.如果需要单独使用某个分享功能，单独导入某个类即可，方法同上，可以选择使用代理或者Block拿到回调，使用代理时，请记得：[HLQQShareManager sharedManager].delegate=self 这样子写。

//5.别忘记在plist的LSApplicationQueriesSchemes中加入 mqq  mqqapi mqqopensdkapiV2 sinaweibohd sinaweibo weibosdk weibosdk2.5 这几个字段，否则不能跳转app
typedef enum : int{
    HLSharePlatformType_WeiXinFriends=1,
    HLSharePlatformType_QQSpace,
    HLSharePlatformType_WeiXinTimeLine,
    HLSharePlatformType_Sina
}HLSharePlatformType;

typedef void(^responseBlock)(id response,BOOL isSuccess,NSString *Info);

#import <Foundation/Foundation.h>

#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface HLShareManager : NSObject<QQApiInterfaceDelegate,WXApiDelegate,WeiboSDKDelegate>

+ (instancetype)sharedManager;

-(BOOL)handleOpenURL:(NSURL *)url;

-(void)ShareWithPlatform:(HLSharePlatformType)type LinkURL:(NSString *)url Title:(NSString *)title Description:(NSString *)desc Image:(UIImage *)image responseBlock:(responseBlock)responseBlock;

@end
