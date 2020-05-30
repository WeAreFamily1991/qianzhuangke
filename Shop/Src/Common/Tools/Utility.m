//
//  Utility.m
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "Utility.h"

#import "NetworkManager.h"


@implementation Utility
// 固定高度，计算字符串宽度
+ (CGFloat)widthForString:(NSString *)string height:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    size = [string boundingRectWithSize:size
                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                             attributes:tdic
                                context:nil].size;
    return size.width;
}

// 固定宽度，计算字符串高度
+ (CGFloat)heightForString:(NSString *)string width:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    size = [string boundingRectWithSize:size
                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                             attributes:tdic
                                context:nil].size;
    return size.height;
}

/**
 根据传入的颜色，生成一个宽高为1的纯色图片。
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, ScreenScale);
    
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 设置填充色
    CGContextSetFillColorWithColor(ref, color.CGColor);
    
    // 渲染
    CGContextFillRect(ref, rect);
    
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭位图
    UIGraphicsEndImageContext();
    
    // 返回图片
    return image;
}

#pragma mark - UserDefaults
/**
 保存信息到 UserDefaults
 
 @param value 需要保存的值
 @param key 对应的 key
 */
+ (void)saveToUserDefaults:(id)value forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

/**
 从 UserDefaults 中获取信息
 */
+ (id)getFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

/**
 从 UserDefaults 移除存储的信息
 */
+ (void)removeFromUserDefaultsForKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

#pragma mark - 游客模式相关操作
/**
 游客模式登录。游客模式需要去后台获取一个 token，接口的调用都需要使用 token，游客的 token 是不会过期的。
 */
+ (void)loginWithGuestMode {
    [[NetworkManager manager] getGuestTokenSuccess:^(id response) {
        // 获取成功之后，保存 token 到 User 中（在 User 中同时会保存到本地）
        NSDictionary *resDict = (NSDictionary *)response;
        
        NSString *token = [resDict valueForKey:@"token"];
        [User currentUser].token = token;
        
        // 发出通知，让其他页面进行相应的操作
        [[NSNotificationCenter defaultCenter] postNotificationName:kGuestLoginStatusChange object:nil userInfo:nil];
        
    } fail:^(NSError *error) {
        
    }];
}

@end
