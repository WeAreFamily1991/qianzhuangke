//
//  MBProgressHUD+SN.h
//
//  BDCarUserIOSProject
//
//  Created by reich on 2018/4/23.
//  Copyright © 2018年 rockDing. All rights reserved.
//

#import <MBProgressHUD.h>

@interface MBProgressHUD (DR)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUD; + (void)hideHUDForView:(UIView *)view;



@end
