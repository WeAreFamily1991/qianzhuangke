//
//  User.h
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

/*
 * 该 User 类用于保存当前用户的信息，是一个单例
 * 如果用户没有登录，就去获取一个游客的 token，
 * 如果用户已经登录，使用自己的 token，并且在每次请求的时候，后台都会返回一个新的 token，更新 User 里面的 token
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

/**
 获取当前用户对象
 */
+ (instancetype)currentUser;

/**
 用户是否登录
 */
@property (nonatomic, assign) BOOL isLogin;

/**
 如果用户没有登录，就去获取一个游客的 token；
 如果用户已经登录，使用自己的 token，并且在每次请求的时候，后台都会返回一个新的 token，更新 User 里面的 token；
 token 的有效时长为12小时。
 */
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *visitetoken;


-(void)loginOut;
-(void)removeToken;
@end

NS_ASSUME_NONNULL_END
