//
//  User.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

/**
 获取当前用户对象
 */
+ (instancetype)currentUser {
    static User *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        // 从本地获取登录状态
        _isLogin = [[Utility getFromUserDefaultsForKey:kUserIsLogin] boolValue];
        
        if (_isLogin) {
            // 从本地获取 token
            _token = [Utility getFromUserDefaultsForKey:kCurrentUserToken];
        } else {
            // 如果没有登录，就是游客模式，尝试从本地获取 token，因为如果是第一次打开 App，本地是没有游客 token 的
            NSString *token = [Utility getFromUserDefaultsForKey:kCurrentVisiteToken];
            if (token && token.length > 0) {
                _visitetoken = token;
            }
        }
    }
    
    return self;
}

#pragma mark - Setter/Getter
- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    
    // 保存到 UserDefaults 中
    [Utility saveToUserDefaults:@(_isLogin) forKey:kUserIsLogin];
}

- (void)setToken:(NSString *)token {
    if (token != nil) {
        _token = [token copy];
        [Utility saveToUserDefaults:_token forKey:kCurrentUserToken];
    }
}
-(void)setVisitetoken:(NSString *)visitetoken
{
    if (visitetoken != nil) {
        _visitetoken = [visitetoken copy];
        [Utility saveToUserDefaults:_visitetoken forKey:kCurrentVisiteToken];
    }
}
-(void)loginOut
{
    self.isLogin =NO;
    [self removeToken];
}
-(void)removeToken
{
    if (_token) {
        [Utility removeFromUserDefaultsForKey:kCurrentUserToken];
    }
}

@end
