//
//  SNAppManager.m
//  TemplateProject-iOS
//
//  Created by User on 2016/12/2.
//  Copyright © 2016年 Felix. All rights reserved.
//

#import "DRAppManager.h"


#import "NSStringSNCategory.h"

#import "MBProgressHUD+DR.h"
//#import "UIBarButtonItem+DR.h"
//#import "SNTabBarController.h"
#import "LoginVC.h"
#import "SNAPI.h"
#import "SNAccount.h"
@implementation DRAppManager

//+ (id)showHomeView {
//
//
////    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SNDevice" bundle:nil];
////    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SNDeviceListVC"];
////    UIViewController *nav = [[SNNavigationController alloc] initWithRootViewController:controller];
//
////    SNTabBarController *tabBarController = [[SNTabBarController alloc] init];
////
////    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
//
//}

+ (id)showLoginView {
    
    [[User currentUser] loginOut];
    
    LoginVC *dcLoginVc = [LoginVC new];
    
    DCNavigationController *nav =  [[DCNavigationController alloc] initWithRootViewController:dcLoginVc];
    nav.modalPresentationStyle =UIModalPresentationFullScreen;
   [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
//    [self presentViewController:nav animated:YES completion:nil];
    return nav;
}

+ (id)logout {
    
   
    if ([SNAccount haveToken]) {
        [SNAccount removeToken];
    }
    [SNAccount removePassword];
    LoginVC *dcLoginVc = [LoginVC new];
    DCNavigationController *nav =  [[DCNavigationController alloc] initWithRootViewController:dcLoginVc];
    nav.modalPresentationStyle =UIModalPresentationFullScreen;
    [[NSNotificationCenter defaultCenter] postNotificationName:DRLogoutNotification object:nil];
    return nav;
}

+ (void)initScinanSDKWithCompanyID:(NSString *)companyID debugAPPKey:(NSString *)debugKey debugAPPSecret:(NSString *)debugSecret releaseAPPKey:(NSString *)releaseKey releaseAPPSecret:(NSString *)releaseSecret {
    
    [SNAPI initWithCompanyID:companyID debugAPPKey:debugKey debugAPPSecret:debugSecret releaseAPPKey:releaseKey releaseAPPSecret:releaseSecret];
    
//    [ isShowLog:YES];
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if ([currentLanguage hasPrefix:@"zh-Hans"] || [currentLanguage hasPrefix:@"zh-Hant"]) {
        [SNAPI setLanguage:@"zh-CN"];
    }
    
    [SNAPI setFailureHanlder:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
        if (error.code < 0) {
            [MBProgressHUD showError:SNStandardString(@"network_error")];
            
        } else if (error.code == 10002 || error.code == 10012 || error.code == 10013) {
            
            [MBProgressHUD showError:SNStandardString(@"re_login")];
            
        } else if ((error.code >= 10000 && error.code != 20003 && error.code != 20002 && error.code != 49999 && error.code != 10003)) {
            // 20002:设备已存在; 20003:设备验证出错，不能添加; 10003:Token过期
            
            [MBProgressHUD showError:error.domain];
            
        } else {
            NSLog(@"错误！error code: %d, errorDomain:%@", (int)error.code, error.domain);
        }
    }];
    
    [SNAPI setTokenErrorHandler:^(NSError *error) {
        // token不可换，重新登录
        [DRAppManager logout];
        [DRAppManager showLoginView];
    }];
    
}

+ (UIBarButtonItem *)getBackBarButtonItemWithTarget:(id)target action:(SEL)action {
    
//    return [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"ico_back_n"] highlightedImage:[UIImage imageNamed:@"ico_back_p"] target:target action:action];
    return [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:action];
//    return [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BACK", nil) style:UIBarButtonItemStyleDone target:target action:action];
}

@end
