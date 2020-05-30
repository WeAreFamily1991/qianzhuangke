//
//  SNToken.h
//  sdk-demo
//
//  Created by User on 16/3/25.
//  Copyright © 2016年 Scinan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNToken : NSObject
@property (nonatomic,copy) NSString *visit_token;
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *expires_in;

/**
 *  账号授权到期时间
 */
@property (nonatomic, strong) NSDate *expiresTime;

@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *mobilePhone;



/**
 *  存档Token，把Token存到沙盒
 */
+ (void)saveVisistToken:(id)token;

/**
 *  解档Token，从沙盒中获取Token
 */
+ (id)loadVisistToken;

/**
 *  存档Token，把Token存到沙盒
 */
+ (void)saveToken:(SNToken *)token;

/**
 *  解档Token，从沙盒中获取Token
 */
+ (SNToken *)loadToken;

+ (NSString *)getFilePath;

@end
