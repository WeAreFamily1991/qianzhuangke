//
//  SNNetworking.h
//
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNetworking : NSObject

/// GETTOKEN
/// @param url URL
/// @param paramers 参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)postVisiteTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/// RESHTOKEN
/// @param url URL
/// @param paramers 参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)postReshTokenURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 *  Post请求
 *
 *  @param url      URL
 *  @param paramers 参数
 */
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


/// nsdata类型
/// @param url URL
/// @param paramers paramers 参数
+ (void)postURL:(NSString *)url parametersWithData:(id )paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure ;
/**
 *  Get请求
 *
 *  @param url      URL
 *  @param paramers 参数
 */
+ (void)getURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
/**
 *  DELETE请求
 *
 *  @param url      URL
 *  @param paramers 参数
 */
+ (void)deleteURL:(NSString *)url parameters:(NSDictionary *)paramers success:(void (^)(id))success failure:(void (^)(NSError *))failure;
/**
 *  Post上传文件
 *
 *  @param url           URL
 *  @param paramers      参数
 *  @param formDataArray SNFormData对象数组
 */
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)paramers formDataArray:(NSArray *)formDataArray success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

+ (void)uploadimgUrl:(NSString *)url imageArr:(NSArray *)imgS parameters:(NSMutableDictionary *)paramers formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end


@interface SNFormData : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  参数的Key
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

/**
 *  文件
 */
@property (nonatomic, copy) NSString *contentType;

@end
