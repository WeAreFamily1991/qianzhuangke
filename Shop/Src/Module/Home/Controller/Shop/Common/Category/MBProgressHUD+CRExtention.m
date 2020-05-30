//
//  MBProgressHUD+CRExtention.m
//  CRShopDetailDemo
//
//  Created by roger wu on 20/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import "MBProgressHUD+CRExtention.h"

static const CGFloat kShowTime = 1.25;
static const CGFloat kLabelFont = 16;
#define kBezelViewColor [UIColor colorWithWhite:0 alpha:0.7]

@implementation MBProgressHUD (CRExtention)

+ (instancetype)cr_showToastWithText:(NSString *)text {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud hideAnimated:YES afterDelay:kShowTime];
    
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:kLabelFont];
    hud.label.numberOfLines = 0;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = kBezelViewColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.minSize = CGSizeMake(100.f, 40.f);
    hud.margin = 10.f;
    
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    return hud;
}

+ (instancetype)cr_showLoadinWithView:(UIView *)view {
    return [self cr_showLoadinWithView:view text:nil];
}

+ (instancetype)cr_showLoadinWithView:(UIView *)view text:(NSString *)text {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    if (text.length > 0) {
        return [self _showLoadinWithView:view text:text];
    } else {
        return [self _showLoadinWithView:view];
    }
}

+ (instancetype)_showLoadinWithView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.label.font = [UIFont boldSystemFontOfSize:kLabelFont];
    hud.label.textColor = BLACKCOLOR;
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.alpha = 0.7;
    [indicator startAnimating];
    hud.customView = indicator;
    
    return hud;
}

+ (instancetype)_showLoadinWithView:(UIView *)view text:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.label.font = [UIFont boldSystemFontOfSize:kLabelFont];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [BLACKCOLOR colorWithAlphaComponent:0.9f];
    hud.margin = 20.f;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

- (void)cr_hide {
    [self hideAnimated:YES];
}

@end
