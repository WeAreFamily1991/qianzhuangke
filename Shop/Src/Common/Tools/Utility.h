//
//  Utility.h
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

/*
 * 工具类方法
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utility : NSObject

/**
 固定高度，计算字符串宽度

 @param string 需要计算宽度的字符串
 @param height 字符串的高度
 @param font 字符串显示时的字体
 @return 字符串的宽度
 */
+ (CGFloat)widthForString:(NSString *)string height:(CGFloat)height font:(UIFont *)font;

/**
 固定宽度，计算字符串高度
 
 @param string 需要计算高度的字符串
 @param width 字符串的宽度
 @param font 字符串显示时的字体
 @return 字符串的高度
 */
+ (CGFloat)heightForString:(NSString *)string width:(CGFloat)width font:(UIFont *)font;


/**
 根据传入的颜色，生成一个宽高为1的纯色图片。

 @param color 图片的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - UserDefaults
/**
 保存信息到 UserDefaults
 
 @param value 需要保存的值
 @param key 对应的 key
 */
+ (void)saveToUserDefaults:(id)value forKey:(NSString *)key;

/**
 从 UserDefaults 中获取信息
 */
+ (id)getFromUserDefaultsForKey:(NSString *)key;

/**
 从 UserDefaults 移除存储的信息
 */
+ (void)removeFromUserDefaultsForKey:(NSString *)key;


#pragma mark - 游客模式相关操作
/**
 游客模式登录。游客模式需要去后台获取一个 token，接口的调用都需要使用 token，游客的 token 是不会过期的。
 */
+ (void)loginWithGuestMode;

@end

NS_ASSUME_NONNULL_END
