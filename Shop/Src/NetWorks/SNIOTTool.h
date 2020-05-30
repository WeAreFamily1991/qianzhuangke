//
//  SNIOTTool.h
//  ZhikeAirConditioning
//
//  Created by User on 16/2/16.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNNetworking.h"

@class SNResult;

@interface SNIOTTool : NSObject
// 获取游客token
+ (void)postvisiteTokenWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *result))success failure:(void (^)(NSError *error))failure;
+ (void)postReshTokenURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *result))success failure:(void (^)(NSError *error))failure;
// 异步POST
+ (void)postWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *result))success failure:(void (^)(NSError *error))failure;
// 异步POST
+ (void)postWithURL:(NSString *)url parametersWithData:(id)dataStr success:(void (^)(SNResult *result))success failure:(void (^)(NSError *error))failure;
//delete
+ (void)deleteWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure;
//get
+ (void)getWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers success:(void (^)(SNResult *))success failure:(void (^)(NSError *))failure;
// 上传
+ (void)postWithURL:(NSString *)url parameters:(NSMutableDictionary *)paramers formDataArray:(NSArray<SNFormData *> *)formDataArray success:(void (^)(SNResult *result))success failure:(void (^)(NSError *error))failure;

// 处理参数
+ (NSDictionary *)processParamers:(NSMutableDictionary *)paramers checkToken:(BOOL)isCheck;

@end
