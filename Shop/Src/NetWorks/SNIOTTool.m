 //
//  SNIOTTool.m
//  ZhikeAirConditioning
//
//  Created by User on 16/2/16.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNIOTTool.h"
#import <UIKit/UIKit.h>
#import "MJExtension.h"
#import "SNResult.h"
//#import "NSMutableDictionaryAddition.h"
#import "SNURL.h"
#import "SNLog.h"
#import "SNAPIManager.h"
#import "SNAccount.h"
#import "SNTool.h"
#import "NSStringSNCategory.h"

@interface SNIOTTool ()

@end

@implementation SNIOTTool
//获取游客token
+ (void)postvisiteTokenWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    //
    //    BOOL isCheckToken = ![url isEqualToString:USER_REFRESH_TOKEN];
    //
    //    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:isCheckToken];
    //    if (!paraDict) {
    //        NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
    //        [self handleFailureError:error failure:failure];
    //        return;
    //    }
    //    if ([User currentUser].isLogin) {
    //
    //    }
   
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
    NSLog(@"baseUrl=%@url=%@ paramers==%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    __weak typeof(self) weakSelf = self;
    [SNNetworking postVisiteTokenURL:url parameters:paramers success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
        
        [weakSelf handleFailureError:error failure:failure];
    }];
}

//刷新token
+ (void)postReshTokenURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    //
    //    BOOL isCheckToken = ![url isEqualToString:USER_REFRESH_TOKEN];
    //
    //    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:isCheckToken];
    //    if (!paraDict) {
    //        NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
    //        [self handleFailureError:error failure:failure];
    //        return;
    //    }
    //    if ([User currentUser].isLogin) {
    //
    //    }
   
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
    NSLog(@"baseUrl=%@url=%@ paramers==%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    __weak typeof(self) weakSelf = self;
    [SNNetworking postReshTokenURL:url parameters:paramers success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
        
        [weakSelf handleFailureError:error failure:failure];
    }];
}
// DELETE
+ (void)deleteWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    //
    //    BOOL isCheckToken = ![url isEqualToString:USER_REFRESH_TOKEN];
    //
    //    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:isCheckToken];
    //    if (!paraDict) {
    //        NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
    //        [self handleFailureError:error failure:failure];
    //        return;
    //    }
    if ([User currentUser].isLogin)
    {
        [paramers setObject:[User currentUser].token forKey:@"santieJwt"];
    }
    else
    {
        [paramers setObject:[DEFAULTS objectForKey:@"visitetoken"] forKey:@"santieJwt"];
    }
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
    NSLog(@"baseUrl=%@url=%@ paramers==%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    __weak typeof(self) weakSelf = self;
    [SNNetworking deleteURL:url parameters:paramers success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
        
        
        [weakSelf handleFailureError:error failure:failure];
    }];
}
// 异步POST
+ (void)postWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {

    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
   
    __weak typeof(self) weakSelf = self;
    [SNNetworking postURL:url parameters:paramers success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
       
        [weakSelf handleFailureError:error failure:failure];
    }];
}


// 异步POST
+ (void)postWithURL:(NSString *)url parametersWithData:(id)dataStr success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
   
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
   
    __weak typeof(self) weakSelf = self;
    [SNNetworking postURL:url parametersWithData:dataStr success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
       
        [weakSelf handleFailureError:error failure:failure];
    }];
}


// GET
+ (void)getWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
//    BOOL isCheckToken = ![url isEqualToString:USER_REFRESH_TOKEN];
//
//    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:isCheckToken];
//    if (!paraDict) {
//        NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
//        [self handleFailureError:error failure:failure];
//        return;
//    }
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:paramers];
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
//    if ([User currentUser].isLogin){
//        NSDateComponents  *coma  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]];
//        NSDateComponents  *coma2  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"refreshTime"]];
//        if (coma2.day>=30) {
//            [DRAppManager showLoginView];
//        }else
//        {
//            if (coma.hour>=10) {
//                [User currentUser].token =[DEFAULTS objectForKey:@"refresh_token"];
//                [dic setObject:[User currentUser].token forKey:@"santieJwt"];
//            }
//            else
//            {
//                if ([User currentUser].token) {
//                    [dic setObject:[User currentUser].token forKey:@"santieJwt"];
//                }
//            }
//        }
//    }
//    else
//    {
//        if ([DEFAULTS objectForKey:@"visitetoken"]) {
//            [dic setObject:[DEFAULTS objectForKey:@"visitetoken"] forKey:@"santieJwt"];
//        }
//    }
   
    __weak typeof(self) weakSelf = self;
    [SNNetworking getURL:url parameters:dic success:^(id response) {
        
        [weakSelf handleSuccessResponse:response success:success failure:failure];
        
    } failure:^(NSError *error) {
       
        [weakSelf handleFailureError:error failure:failure];
    }];
}

// 上传
+ (void)postWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers formDataArray:(NSArray *)formDataArray success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
//    BOOL isCheckToken = ![url isEqualToString:USER_REFRESH_TOKEN];
//
//    NSDictionary *paraDict = [SNIOTTool processParamers:paramers checkToken:isCheckToken];
//    if (!paraDict) {
//        NSError *error = [NSError errorWithDomain:@"need token" code:10002 userInfo:nil];
//        [self handleFailureError:error failure:failure];
//        return;
//    }
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
    }
    NSString*tokenStr;
    if ([User currentUser].isLogin)
    {
       
        tokenStr=[User currentUser].token;
//        [paramers setObject:[User currentUser].token forKey:@"santieJwt"];
    }
    else
    {
        tokenStr = [DEFAULTS objectForKey:@"visitetoken"];
//        [paramers setObject:[User currentUser].visitetoken forKey:@"santieJwt"];
    }
    url =[NSString stringWithFormat:@"%@?santieJwt=%@",url,tokenStr];    
    __weak typeof(self) weakSelf = self;
    
    [SNNetworking postURL:url parameters:paramers formDataArray:formDataArray success:^(id response) {
        [weakSelf handleSuccessResponse:response success:success failure:failure];

    } failure:^(NSError *error) {
       
        [weakSelf handleFailureError:error failure:failure];
    }];
}

#pragma mark -

+(NSString *)removeUnescapedCharacter:(NSString *)inputStr {
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];//获取那些特殊字符
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];//寻找字符串中有没有这些特殊字符
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound) {
            
//            UniChar c = [mutable characterAtIndex:range.location];
//            NSLog(@"%C", c);
            [mutable deleteCharactersInRange:range];//去掉这些特殊字符
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
    
}

+ (void)handleSuccessResponse:(id)response success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure {
    
    SNResult *result = [SNResult mj_objectWithKeyValues:response];
    
    if (!result) {
        NSString *str = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSString *newStr = [self removeUnescapedCharacter:str];
        result = [SNResult mj_objectWithKeyValues:newStr];
    }    
    // 30017：第三方登录，用户未绑定;30018：第三方登录，用户已绑定
    if (result.state == 200 || result.state == 30053 || result.state == 30117 || result.state == 30118) {
        
        if ([SNAPIManager shareAPIManager].successHanlder) {
            [SNAPIManager shareAPIManager].successHanlder(result);
        }
        if (success) {
            success(result);
        }
        
    } else {
        
        NSString *domain = result.msg;
        if (!domain) {
            domain = @"";
        }
        NSError *error = [[NSError alloc] initWithDomain:domain code:result.state userInfo:result.data];
        
        if ([SNAPIManager shareAPIManager].failureHanlder) {
            [SNAPIManager shareAPIManager].failureHanlder(error);
        }
        if (failure) {
            failure(error);
        }
//        if (error.code==401) {
//            [MBProgressHUD showError:@"请先去登录"];
//            DELAY(1);
//            [DRAppManager showLoginView];
//        }
//        if (error.code == 10002 || error.code == 10012 || error.code == 10013) { // token不可换，重新登录
//            if ([SNAPIManager shareAPIManager].tokenErrorHanlder) {
//                [SNAPIManager shareAPIManager].tokenErrorHanlder(error);
//            }
//        }
    }
}

+ (void)handleFailureError:(NSError *)error failure:(void (^)(NSError *))failure {
    
    if ([SNAPIManager shareAPIManager].failureHanlder) {
        [SNAPIManager shareAPIManager].failureHanlder(error);
    }
    if (failure) {
        failure(error);
    }
    if (error.code == 10002 || error.code == 10012 || error.code == 10013) { // token不可换，重新登录
        if ([SNAPIManager shareAPIManager].tokenErrorHanlder) {
            [SNAPIManager shareAPIManager].tokenErrorHanlder(error);
        }
    }
}
+ (NSDictionary *)processParamers:(NSMutableDictionary *)paramers checkToken:(BOOL)isCheck {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC+0800"]];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    SNAPIManager *manager = [SNAPIManager shareAPIManager];
    NSDateFormatter *msdateFormatter = [[NSDateFormatter alloc] init];
    [msdateFormatter setDateFormat:@"yyyyMMddHHmmssSS"];
    NSDate *currentDate = [NSDate date];
    NSString *msdateStr = [msdateFormatter stringFromDate:currentDate];
    NSString *request_IDStr=[NSString stringWithFormat:@"%@%@",identifierForVendor,msdateStr];
    NSString *client = [NSString stringWithFormat:@"%@,%@", [SNTool getDeviceModel], [UIDevice currentDevice].systemVersion];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *client_version = [NSString stringWithFormat:@"%@,%@", app_Version, app_build];
    NSDictionary *dicPara = @{@"app_key":manager.appKey,
                              @"company_id":manager.companyID,
                              @"location":manager.location,
                              @"format":manager.format,
                              @"timestamp":currentDateStr,
                              @"imei":identifierForVendor,
                              @"language":manager.language,
                              @"client" : client,
                              @"client_version" : client_version,
                              @"network" : [SNTool getNetWorkStates],
                              @"request_id":[request_IDStr upperMD5]};
    
    NSMutableDictionary *reDic = [[NSMutableDictionary alloc] initWithDictionary:paramers];
    for (NSString *key in dicPara) {
        [reDic setObject:[dicPara objectForKey:key] forKey:key];
    }
    
    if ([[reDic allKeys] containsObject:@"token"]) {
        if (manager.token.length) {
            [reDic setObject:manager.token forKey:@"token"];
            if (isCheck) {
                [manager checkToken];
            }
            
        } else {
            [SNLog log:@"缺少Token!"];
            return nil;
        }
    }
//    [reDic setObject:[reDic snCreateSNSDKAutograph] forKey:@"sign"];
    
    return [NSDictionary dictionaryWithDictionary:reDic];
}

@end
