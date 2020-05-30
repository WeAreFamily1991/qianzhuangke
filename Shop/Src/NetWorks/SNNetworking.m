//
//  SNNetworking.m
//  sdk-demo
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNNetworking.h"
#import "AFNetworking.h"
#import "SNLog.h"
#import "SNAPI.h"
#import "MJExtension.h"
#import "SNAPIManager.h"

#import "NSObject+SN.h"

@implementation SNNetworking

#pragma mark - gettoken请求方法
+ (void)postVisiteTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    __weak typeof(self) weakSelf = self;   
     NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager POST:url parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postReshTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    [manager.requestSerializer setValue:[DEFAULTS objectForKey:@"refresh_token"] forHTTPHeaderField:@"santie-jwt"];
    __weak typeof(self) weakSelf = self;
     NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager POST:url parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    if ([User currentUser].isLogin)
    {
        NSDateComponents  *coma  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]];
        NSDateComponents  *coma2  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"refreshTime"]];
        if (coma2.day>=30) {
            [DRAppManager showLoginView];
        }else
        {
            if (coma.hour>=10) {
                [SNAPI refreshToken];
                [manager.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
            }
            else
            {
                if ([User currentUser].token) {
                    [manager.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
                }
            }
        }
    }
    else
    {
        if ([DEFAULTS objectForKey:@"visitetoken"]) {
            [manager.requestSerializer setValue:[DEFAULTS objectForKey:@"visitetoken"] forHTTPHeaderField:@"santie-jwt"];
        }
        else
        {
            [SNAPI getToken];
        }
    }
    __weak typeof(self) weakSelf = self;
   
     NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager POST:url parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)postURL:(NSString *)url parametersWithData:(id)json success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:json];
    AFHTTPSessionManager *manager11 = [AFHTTPSessionManager manager];
    manager11.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager11.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"application/json" forKey:@"Content-Type"];
    [manager11.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager11.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    
    if ([User currentUser].isLogin)
    {
        NSDateComponents  *coma  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]];
        NSDateComponents  *coma2  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"refreshTime"]];
        if (coma2.day>=30) {
            [DRAppManager showLoginView];
        }else
        {
            if (coma.hour>=10) {
               [SNAPI refreshToken];
                [manager11.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
            }
            else
            {
                if ([User currentUser].token) {
                    [manager11.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
                }
            }
            
        }
    }
    else
    {
        if ([DEFAULTS objectForKey:@"visitetoken"]) {
            [manager11.requestSerializer setValue:[DEFAULTS objectForKey:@"visitetoken"] forHTTPHeaderField:@"santie-jwt"];
        }
        else
        {
            [SNAPI getToken];
        }
    }
    NSRange range = [url rangeOfString:@"http"];
    if (!range.length) {
        url = [NSString stringWithFormat:@"%@%@", [SNAPIManager shareAPIManager].baseURL, url];
//    }
    //    __weak typeof(self) weakSelf = self;    // request
//    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", kBaseUrl, url];
  
    
//    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    manager.responseSerializer = responseSerializer;
        DRWeakSelf;
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            if (success) {
                success(responseObject);
            }
            
        } else {
            if (failure) {
                failure(error);
            }
        }
    }] resume];
}
//        [manager POST:url parameters:paramers progress:^(NSProgress * _Nonnull uploadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//f printResponse:responseObject url:url parameters:paramers];
//    //        [weakSelf cheakTokenWithResponse:responseObject];
//            if (success) {
//                success(responseObject);
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    //        [weakSelf printError:error url:url parameters:paramers];
//
//            if (failure) {
//                failure(error);
//            }
//        }];
}
#pragma mark - delete请求方法

+ (void)deleteURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    __weak typeof(self) weakSelf = self;
     NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager DELETE:url parameters:paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf printError:error url:url parameters:paramers];
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
     NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager POST:url parameters:paramers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < formDataArray.count; i++) {
            UIImage *image = formDataArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    __weak typeof(self) weakSelf = self;
//    [manager POST:url parameters:paramers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (SNFormData *data in formDataArray){
//            [formData appendPartWithFileData:data.fileData name:data.name fileName:data.fileName mimeType:data.mimeType];
//        }
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        [weakSelf printResponse:responseObject url:url parameters:paramers];
//        [weakSelf cheakTokenWithResponse:responseObject];
//
//        if (success) {
//            success(responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        [weakSelf printError:error url:url parameters:paramers];
//        if (failure) {
//            failure(error);
//        }
//    }];
}


#pragma mark - GET请求方法

+ (void)getURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"sourceType"];
    if ([User currentUser].isLogin)
    {
        NSDateComponents  *coma  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"expireTime"]];
        NSDateComponents  *coma2  =[SNTool compareDatecurrentTimewithLaterTime:[DEFAULTS objectForKey:@"refreshTime"]];
        if (coma2.day>=30) {
            [DRAppManager showLoginView];
        }else
        {
            if (coma.hour>=10) {
               [SNAPI refreshToken];
                [manager.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
                 NSLog(@"token=%@",[User currentUser].token);
            }
            else
            {
                if ([User currentUser].token) {
                    [manager.requestSerializer setValue:[User currentUser].token forHTTPHeaderField:@"santie-jwt"];
                      NSLog(@"token=%@",[User currentUser].token);
                }
            }
        }
    }
    else
    {
        if ([DEFAULTS objectForKey:@"visitetoken"]) {
            NSLog(@"visitetoken=%@",[DEFAULTS objectForKey:@"visitetoken"]);
            [manager.requestSerializer setValue:[DEFAULTS objectForKey:@"visitetoken"] forHTTPHeaderField:@"santie-jwt"];
        }
        else
        {
            [SNAPI getToken];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    NSLog(@"baseUrl==%@url==%@===mudic===%@",[SNAPIManager shareAPIManager].baseURL,url,paramers);
    [manager GET:url parameters:paramers progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf printResponse:responseObject url:url parameters:paramers];
        [weakSelf cheakTokenWithResponse:responseObject];        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [weakSelf printError:error url:url parameters:paramers];
        if (error.code==401) {
            [MBProgressHUD showError:@"请先去登录"];
            DELAY(1);
            [DRAppManager showLoginView];
        }
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 打印

+ (NSString *)spliceUrlWithUrl:(NSString *)url parameters:(NSDictionary *)params {
    
    NSString *requestStr=[NSString stringWithFormat:@"%@?",url];
    NSArray *keys = [params allKeys];
    for (int i = 0; i < keys.count; i ++) {
        NSString *key = keys[i];
        if (i == 0) {
            requestStr = [NSString stringWithFormat:@"%@%@=%@",requestStr,key,params[key]];
        } else {
            requestStr = [requestStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,params[key]]];
        }
    }
    
    return requestStr;
}

+ (void)printResponse:(id)response url:(NSString *)url parameters:(NSDictionary *)params {
    
    if (![SNAPIManager shareAPIManager].isShowLog) {
        return;
    }
    
    NSString *responseStr = [[response mj_JSONObject] descriptionUTF8];
//    NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
    
    [SNLog log:@"\nURL:\n%@\n收到：\n%@", urlStr, responseStr];
}

+ (void)printError:(NSError *)error url:(NSString *)url parameters:(NSDictionary *)params {
    
    if (![SNAPIManager shareAPIManager].isShowLog) {
        return;
    }
    
    NSString *urlStr = [self spliceUrlWithUrl:url parameters:params];
    
    [SNLog log:@"\nURL:\n%@\n错误：\n%@", urlStr, error];
}

#pragma mark - 检测换票
+ (void)cheakTokenWithResponse:(id)response {
    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
    id dict = [response mj_JSONObject];
    
    if ([dict isKindOfClass:[NSDictionary class]]) {

        if ([[NSString stringWithFormat:@"%@",dict[@"state"]] isEqualToString:@"10003"]) {
            [SNAPI userRefreshTokenSuccess:^{
                
            } failure:^(NSError *error) {
                
            }];
        }
    }
}

@end

@implementation SNFormData


@end

