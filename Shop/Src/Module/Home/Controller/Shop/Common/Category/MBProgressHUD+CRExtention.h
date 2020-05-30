//
//  MBProgressHUD+CRExtention.h
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (CRExtention)

+ (instancetype)cr_showToastWithText:(NSString *)text;

+ (instancetype)cr_showLoadinWithView:(UIView *)view;

+ (instancetype)cr_showLoadinWithView:(UIView *)view text:(NSString *)text;

- (void)cr_hide;

@end
