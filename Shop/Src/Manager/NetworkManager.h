//
//  NetworkManager.h
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络请求相关的常量都在这个文件中
#import "NetworkConstants.h"


/**
 请求成功的回调，AFN 的请求，最后回调已经回到了主线程。
 
 @param response 响应数据
 */
typedef void(^SuccessBlock)(id response);

/**
 请求失败回调
 
 @param error Error 对象
 */
typedef void(^FailBlock)(NSError *error);


NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

/**
 网络请求单例
 */
+ (instancetype)manager;

#pragma mark - 用户信息相关接口

/**
 获取游客 token
 */
- (void)getGuestTokenSuccess:(SuccessBlock)success fail:(FailBlock)fail;

#pragma mark - 首页相关接口
/**
 获取首页新闻通知

 @param page 要获取第几页的数据
 @param pageSize 每页多少条数据
 */
- (void)homeGetNewsPage:(NSInteger)page pageSize:(NSInteger)pageSize success:(SuccessBlock)success fail:(FailBlock)fail;

/**
 获取首页新品推荐
 */
- (void)homeGetNewRecommendSuccess:(SuccessBlock)success fail:(FailBlock)fail;

@end

NS_ASSUME_NONNULL_END
