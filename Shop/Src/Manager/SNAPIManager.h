//
//  SNAPIManager.h
//  sdk-demo
//
//  Created by User on 16/3/19.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNResult, SNVersionCheck;

@interface SNAPIManager : NSObject

@property (nonatomic, copy) NSString *token;

@property (nonatomic, strong) NSDate *expiresTime;

@property (nonatomic, strong) void (^successHanlder)(SNResult *result);
@property (nonatomic, strong) void (^failureHanlder)(NSError *error);
@property (nonatomic, strong) void (^tokenErrorHanlder)(NSError *error);

@property (nonatomic, assign) BOOL isConnectFormalServer;

@property (nonatomic, assign) BOOL isShowLog;

@property (nonatomic, copy) NSString *companyID;

@property (nonatomic, copy) NSString *format;

@property (nonatomic, copy) NSString *language;

@property (nonatomic, copy) NSString *debugKey;

@property (nonatomic, copy) NSString *debugSecret;

@property (nonatomic, copy) NSString *releaseKey;

@property (nonatomic, copy) NSString *releaseSecret;

@property (nonatomic, copy) NSString *baseURL;

@property (nonatomic, copy) NSString *appKey;

@property (nonatomic, copy) NSString *appSecret;

@property (nonatomic, copy) NSString *mqttPushURL;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, strong) id deviceConfig;

@property (nonatomic, assign) BOOL isNode;

@property (nonatomic, assign) BOOL isUseLocation;

@property (copy, nonatomic) NSString *bugHdKey;

+ (SNAPIManager *)shareAPIManager;

- (BOOL)checkToken;

@end
