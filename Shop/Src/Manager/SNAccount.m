//
//  SNAccount.m
//  sdk-demo
//
//  Created by User on 16/3/25.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNAccount.h"
#import "NSDataSNCategory.h"
#import "NSStringSNCategory.h"
#import "MJExtension.h"
#import "SNLog.h"
#import "SNToken.h"
#import "SNAPI.h"
#import "SNAPIManager.h"

#define KAccountFile    @"sniot_account_lh"

#define KEncryptKey     @"tyfuygbuh789vfery675342owiutuyvgib678tevr"

@implementation SNAccount

+ (NSString *)defaultPath {
    
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/sdk", pathDocuments];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return createPath;
}

#pragma mark - 存储账号

// 获取账号文件路径
+ (NSString *)getAccountFilePath {
    
    NSString *fileName = [NSString stringWithFormat:@"%@.data", [KAccountFile MD5]];
    return [[self defaultPath] stringByAppendingPathComponent:fileName];
}

+ (void)saveAccount:(NSString *)account password:(NSString *)password areaCode:(NSString *)areaCode  {
    
    if (!account.length) {
        [SNLog log:@"缺少账号"];
    }
    
    SNAccount *acc = [[SNAccount alloc] init];
    acc.account = account;
    if (password) acc.password = password;
    if (areaCode) acc.areaCode = areaCode;
    
    NSData *data = [[acc mj_JSONData] AES256EncryptWithKey:KEncryptKey];
    [NSKeyedArchiver archiveRootObject:data toFile:[self getAccountFilePath]];
}

+ (void)saveAccount:(NSString *)account password:(NSString *)password areaCode:(NSString *)areaCode areaName:(NSString *)areaName  {
    
    if (!account.length) {
        [SNLog log:@"缺少账号"];
    }
    
    SNAccount *acc = [[SNAccount alloc] init];
    acc.account = account;
    if (password) acc.password = password;
    if (areaCode) acc.areaCode = areaCode;
    if (areaName) acc.areaName = areaName;
    
    NSData *data = [[acc mj_JSONData] AES256EncryptWithKey:KEncryptKey];
    [NSKeyedArchiver archiveRootObject:data toFile:[self getAccountFilePath]];
}

+ (void)saveAccount:(NSString *)account password:(NSString *)password   {
    
    if (!account.length) {
        [SNLog log:@"缺少账号"];
    }
    
    SNAccount *acc = [[SNAccount alloc] init];
    acc.account = account;
    if (password) acc.password = password;
    
    NSData *data = [[acc mj_JSONData] AES256EncryptWithKey:KEncryptKey];
    [NSKeyedArchiver archiveRootObject:data toFile:[self getAccountFilePath]];
}
+ (SNAccount *)loadAccount {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[self getAccountFilePath]]) {
        return nil;
    }
    
    NSData *data = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self getAccountFilePath]] AES256DecryptWithKey:KEncryptKey];
    return [SNAccount mj_objectWithKeyValues:data];
}

+ (void)removeAccount {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self getAccountFilePath]]) {
        [manager removeItemAtPath:[self getAccountFilePath] error:nil];
    }
    
    [self removeToken];
}

+ (void)removePassword {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[self getAccountFilePath]]) {
        return;
    }
    
    SNAccount *acc = [self loadAccount];
    [self saveAccount:acc.account password:nil areaCode:acc.areaCode areaName:acc.areaName];
}

#pragma mark - Token

+ (BOOL)haveToken {
    SNToken *token = [SNToken loadToken];
    if (token.access_token) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)refreshToken {
    [SNAPI userRefreshTokenSuccess:^{
        
    } failure:^(NSError *error) {
        
    }];
}

+ (void)removeToken {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[SNToken getFilePath]]) {
        [manager removeItemAtPath:[SNToken getFilePath] error:nil];
    }
    
    SNAPIManager *apiManager = [SNAPIManager shareAPIManager];
    apiManager.token = nil;
    apiManager.expiresTime = nil;
}

@end
