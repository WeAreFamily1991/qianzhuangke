//
//  SNToken.m
//  sdk-demo
//
//  Created by User on 16/3/25.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import "SNToken.h"
#import "NSDataSNCategory.h"
#import "MJExtension.h"
#import "NSStringSNCategory.h"

#define KEncryptKey     @"tyfuygbuh789vfery675342owiutuyvgib678tevr"

@interface SNToken ()

@property (nonatomic, strong) NSData *tokenData;

@end

@implementation SNToken

//解档
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
        self.tokenData = [aDecoder decodeObjectForKey:@"tokenData"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

//存档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [aCoder encodeObject:self.tokenData forKey:@"tokenData"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

- (void)setExpires_in:(NSString *)expires_in {
    _expires_in = expires_in;
    
    _expiresTime = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

#pragma mark - 

+ (NSString *)defaultPath {
    
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/sdk", pathDocuments];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return createPath;
}

+ (NSString *)getFilePath {
    
    NSString *fileName = [NSString stringWithFormat:@"%@.data", [@"sniot_token_lh" MD5]];
    return [[self defaultPath] stringByAppendingPathComponent:fileName];
}
// 存档Token
+ (void)saveVisistToken:(id)token {
    
    SNToken *vistToken = [[SNToken alloc] init];

    vistToken.visit_token =token;
  
}

//// 解档Token
//+ (id)loadVisistToken {
//    
//    NSFileManager *manager = [NSFileManager defaultManager];
//    if (![manager fileExistsAtPath:[self getFilePath]]) {
//        return nil;
//    }
//    
//    SNToken *token = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
//    
//    NSData *data = [token.tokenData AES256DecryptWithKey:KEncryptKey];
//    token.access_token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    token.tokenData = nil;
//    
//    return token;
//}


// 存档Token
+ (void)saveToken:(SNToken *)token {
    
    SNToken *newToken = [[SNToken alloc] init];
    newToken.expiresTime = token.expiresTime;
    newToken.password = token.password;
//    newToken.tokenData = [[token.access_token dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:KEncryptKey];
     newToken.tokenData = [[token.access_token dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:KEncryptKey];
    
    [NSKeyedArchiver archiveRootObject:newToken toFile:[self getFilePath]];
}

// 解档Token
+ (SNToken *)loadToken {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[self getFilePath]]) {
        return nil;
    }
    
    SNToken *token = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath]];
    
    NSData *data = [token.tokenData AES256DecryptWithKey:KEncryptKey];
    token.access_token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    token.tokenData = nil;

    return token;
}

@end
