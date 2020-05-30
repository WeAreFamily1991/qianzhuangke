//
//  versionCheck.m
//  scinansdkframework
//
//  Created by Felix on 2017/3/22.
//  Copyright © 2017年 Scinan. All rights reserved.
//

#import "SNVersionCheck.h"
#import "SNNetworking.h"
//#import "SNAPI.h"
#import <UIKit/UIKit.h>
#import "SNAPIManager.h"

@interface SNVersionCheck () <UIAlertViewDelegate>

@end

@implementation SNVersionCheck

+ (void)checkAppVersionAndShowAlertViewResult:(void (^)(BOOL))result {
    
    // 判断是否连接正式服
    if (![SNAPIManager shareAPIManager].isConnectFormalServer) {
        return;
    }
    
    // 清除所有的URL缓存Response
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@", [[NSBundle mainBundle] bundleIdentifier]];
    
    __weak typeof(self) weakSelf = self;
    
    [SNNetworking getURL:url parameters:nil success:^(id response) {
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
        NSArray *arrResults = [json objectForKey:@"results"];
        
        if ([arrResults count] > 0) {
            NSDictionary *dictAppData = [arrResults objectAtIndex:0];
            
            if ([dictAppData objectForKey:@"bundleId"]) {
                
                NSString *newVersion = [dictAppData objectForKey:@"version"];
                NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                
                if ([localVersion compare:newVersion options:NSNumericSearch] == NSOrderedAscending) {
                    
//                    NSString *version = [localVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
//                    version = [version stringByReplacingOccurrencesOfString:@"_T" withString:@""];
//                    [SNAPI updateAPPWithVersionCode:version os:@"ios" success:^(NSDictionary *resuleDta) {
//                        
//                        NSInteger versinCode = [resuleDta[@"versin_code"] integerValue];
//                        if (versinCode == [version integerValue]) {
//                            BOOL isForce = [resuleDta[@"force"] boolValue];
//                            [weakSelf showAlertWith:dictAppData force:isForce];
//                        } else {
//                            [weakSelf showAlertWith:dictAppData force:NO];
//                        }
//                        
//                    } failure:^(NSError *error) {
                        [weakSelf showAlertWith:dictAppData force:NO];
//                    }];
                    
                    if (result) {
                        result(YES);
                    }
                    
                    return;
                }
            }
        }
        
        if (result) {
            result(NO);
        }
    
    } failure:^(NSError *error) {
        
        if (result) {
            result(NO);
        }
    }];
}

+ (void)showAlertWith:(NSDictionary *)appMessage force:(BOOL)isForce {
    
    NSString *releaseNotes = [appMessage objectForKey:@"releaseNotes"];
    NSString *trackViewUrl = [appMessage objectForKey:@"trackViewUrl"];
//    NSString *newVersion = [appMessage objectForKey:@"version"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"isForce"] =  [NSNumber numberWithBool:isForce];
    dict[@"lastCheckData"] = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"VersionCheckDictionary"];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[self localizedStringForKey:@"升级提示"] message:releaseNotes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[self localizedStringForKey:@"下次再说"] style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[self localizedStringForKey:@"立即更新"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url=[NSURL URLWithString:trackViewUrl];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:okAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
}

+ (NSString *)localizedStringForKey:(NSString *)key {
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"SNSDK" ofType:@"bundle"]];
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [bundle localizedStringForKey:key value:nil table:@"SNSDKString"];
}

@end
