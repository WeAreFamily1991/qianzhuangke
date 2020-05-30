//
//  UIView+HUD.h
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MBProgressHUD;

@interface UIView (HUD)
/**
 显示 loading
 
 @param view 将 HUD 添加在哪个 view 上，可为空，默认添加到 window 上
 */
- (MBProgressHUD *)showLoadingOnView:(nullable UIView *)view;

/**
 显示带有文字信息的 loading
 
 @param view 将 HUD 添加在哪个 view 上，可为空，默认添加到 window 上
 @param message 需要显示的文字
 */
- (MBProgressHUD *)showLoadingOnView:(nullable UIView *)view message:(NSString *)message;

/**
 显示 Toast
 
 @param message 需要显示的文字内容
 @param view 将 HUD 添加在哪个 view 上，可为空，默认添加到 window 上
 */
- (MBProgressHUD *)showToast:(NSString *)message onView:(nullable UIView *)view;

/**
 隐藏 loading
 */
- (void)hideLoading;

@end

