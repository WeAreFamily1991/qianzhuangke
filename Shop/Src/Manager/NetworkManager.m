//
//  NetworkManager.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "NetworkManager.h"

#import <AFNetworking/AFNetworking.h>

#import "User.h" // 用户类，放在这里其实已经产生耦合了。

@interface NetworkManager ()

// 由于后台的接口在设计的时候，有些请求是以 form-data 的形式，有些请求是以 JSON 的形式，
// 所以这里创建两个 AFHTTPSessionManager，分别对应不同的请求。

/**
 以 form-data 形式的请求都使用这个 manager
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


/**
 以 JSON 形式的请求都使用 jsonManager
 */
@property (nonatomic, strong) AFHTTPSessionManager *jsonManager;

@end

@implementation NetworkManager

#pragma mark - Public
/**
 网络请求单例
 */
+ (instancetype)manager {
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        // 初始化以 form-data 格式发起请求的 AFHTTPSessionManager
        // 默认情况下，
        // requestSerializer 是 AFHTTPRequestSerializer 对象，请求时数据是以 formdata 形式传送的，
        // responseSerializer 是 AFJSONResponseSerializer 对象，返回的数据都格式化成 JSON 的格式
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DEBUGAPI_ROOT]];
        // 设置请求超时时间
        _manager.requestSerializer.timeoutInterval = 30.0;
        
        
        // 初始化以 JSON 格式发起请求的 AFHTTPSessionManager
        _jsonManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:DEBUGAPI_ROOT]];
        _jsonManager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:0];
        // 设置请求超时时间
        _jsonManager.requestSerializer.timeoutInterval = 30.0;
    }
    
    return self;
}

#pragma mark - 用户信息相关接口
/**
 获取游客 token
 */
- (void)getGuestTokenSuccess:(SuccessBlock)success fail:(FailBlock)fail {
    NSDictionary *params = @{
                             @"username": @"zhangwu",
                             @"secret": @"dGVzdA=="
                             };
    
    [self POST:API_GuestToken parameters:params success:success fail:fail];
}

#pragma mark - 首页相关接口
/**
 获取首页新闻通知
 
 @param page 要获取第几页的数据
 @param pageSize 每页多少条数据
 */
- (void)homeGetNewsPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(SuccessBlock)success fail:(FailBlock)fail {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self setDefaultParams:params];
    
//    params[@"typeCode"] =
    
    
    [self GET:API_News parameters:params success:success fail:fail];
}

/**
 获取首页新品推荐
 */
- (void)homeGetNewRecommendSuccess:(SuccessBlock)success fail:(FailBlock)fail {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [self setDefaultParams:params];
    
    params[@"type"] = @"1"; // 0:PC端，1：移动端
    
    [self GET:API_NewRecommend parameters:params success:success fail:fail];
}

#pragma mark - Private
// 设置默认参数
- (void)setDefaultParams:(NSMutableDictionary *)params {
    params[@"santieJwt"] = [User currentUser].token;
}

// 请求成功的处理（提取出来，减少重复代码）
- (void)resultHandler:(id)responseObject success:(SuccessBlock)success fail:(FailBlock)fail {
    NSDictionary *resDict = (NSDictionary *)responseObject;
    
    NSInteger state = [[resDict valueForKey:@"state"] integerValue];
    if (state == NetWorkStatusSuccess) {
        // 请求成功
        
        if ([User currentUser].isLogin) {
            // 如果用户已经登录，每次请求产生新的 token，需要更新到 User
            NSString *token = [resDict valueForKey:@"token"];
            [User currentUser].token = token;
        }
        
        success(responseObject);
    } else {
        NSError *error = [NSError errorWithDomain:@"com.santie.shop.networkError" code:state userInfo:nil];
        fail(error);
    }
}

#pragma mark form-data 形式发起的 GET，POST 请求
// 这个只是把 AFN 的 POST 请求又包了一层，目的是在这个文件中少写一些重复代码
- (void)POST:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success fail:(FailBlock)fail {
    DRWeakSelf;
    [_manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf resultHandler:responseObject success:success fail:fail];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

// 这个只是把 AFN 的 GET 请求又包了一层，目的是在这个文件中少写一些重复代码
- (void)GET:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success fail:(FailBlock)fail {
   DRWeakSelf;
    [_manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf resultHandler:responseObject success:success fail:fail];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

#pragma mark JSON 形式发起的 GET，POST 请求
// 这个只是把 AFN 的 POST 请求又包了一层，目的是在这个文件中少写一些重复代码
- (void)jsonPOST:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success fail:(FailBlock)fail {
    DRWeakSelf;
    [_jsonManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf resultHandler:responseObject success:success fail:fail];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

// 这个只是把 AFN 的 GET 请求又包了一层，目的是在这个文件中少写一些重复代码
- (void)jsonGET:(NSString *)url parameters:(id)parameters success:(SuccessBlock)success fail:(FailBlock)fail {
    DRWeakSelf;
    [_jsonManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf resultHandler:responseObject success:success fail:fail];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

@end
