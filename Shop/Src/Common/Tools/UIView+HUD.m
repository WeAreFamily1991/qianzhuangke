//
//  UIView+HUD.m
//  Shop
//
//  Created by BWJ on 2018/12/28.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "UIView+HUD.h"

#import <objc/runtime.h>
#import <MBProgressHUD/MBProgressHUD.h>

const static void * kTargetView = @"kTargetView";
// 默认显示时间 2 秒
static const NSTimeInterval kDefaultHideDelat = 2.0f;
// 默认 GraceTime 0.5 秒
static const NSTimeInterval kDefaultGraceTime = 0.5f;

@implementation UIView (HUD)

#pragma mark - Public
/**
 显示 loading
 */
- (MBProgressHUD *)showLoadingOnView:(nullable UIView *)view {
    
    MBProgressHUD *hud = [self createHUDOnView:view animated:YES];
    return hud;
}

/**
 显示带有文字信息的 loading
 */
- (MBProgressHUD *)showLoadingOnView:(nullable UIView *)view message:(NSString *)message {
    
    MBProgressHUD *hud = [self createHUDOnView:view animated:YES];
    hud.label.text = message;
    return hud;
}

/**
 显示 Toast
 */
- (MBProgressHUD *)showToast:(NSString *)message onView:(nullable UIView *)view {
    
    MBProgressHUD *hud = [self createHUDOnView:view animated:YES];
    
    // 设置 mode 为 MBProgressHUDModeText
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    
    [hud hideAnimated:YES afterDelay:kDefaultHideDelat];
    
    return hud;
}

/**
 隐藏 loading
 */
- (void)hideLoading {
    
    UIView *targetView = [self targetView];
    if (targetView == nil) { // 为空说明 HUD 是显示在当前的 view 上的
        targetView = self;
    }
    
    [MBProgressHUD hideHUDForView:targetView animated:YES];
    
    // 移除绑定的 targetView
    objc_removeAssociatedObjects(self);
}

#pragma mark - Private

/**
 统一处理 targetView，如果有传入了 view，使用传入的 view 作为 targetView，否则使用 self；
 
 @param view 调用时传入的 view
 @return 最终 HUD 要添加到的 view
 */
- (UIView *)handleTargetView:(UIView *)view {
    UIView *targetView;
    
    if (view) {
        if (self == view) { // 比较的是指针
            // 将 HUD 添加到当前 view 上
            targetView = self;
        } else {
            // 将 HUD 添加到指定的 view 上
            targetView = view;
            // 保存 targetView，在隐藏的时候需要用到
            [self setTargetView:targetView];
        }
    } else {
        targetView = [UIApplication sharedApplication].keyWindow;
        [self setTargetView:targetView];
    }
    
    return targetView;
}

// 通过 runtime 的方法，添加一个 targetView 的属性，显示 HUD 时，保存它所添加到的 view
- (void)setTargetView:(UIView *)targetView {
    objc_setAssociatedObject(self, kTargetView, targetView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)targetView {
    return objc_getAssociatedObject(self, kTargetView);
}

// 创建 HUD 并返回，用这个方法的目的是为了在一个地方统一设置 HUD 的一些属性
- (MBProgressHUD *)createHUDOnView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self handleTargetView:view] animated:YES];
    hud.graceTime = kDefaultGraceTime;
    // 隐藏时从父 view 上移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 文字颜色
    hud.contentColor = [UIColor whiteColor];
    
    // 设置 hud 背景色
//    hud.bezelView.backgroundColor = ColorWithHexString(@"");
    
    return hud;
}



@end
