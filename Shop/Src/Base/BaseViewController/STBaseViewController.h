//
//  STBaseViewController.h
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <RTRootNavigationController/RTRootNavigationController.h>
#import <RTRootNavigationController/UIViewController+RTRootNavigationController.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBaseViewController : UIViewController

@property (nonatomic,retain)CLPlacemark *myPlaceMark;
@property (nonatomic,retain)NSString *locationStr;
/**
 设置 navigationBar 上面的字体为白色
 */
- (void)setWhiteNavigationBarTitle;

/**
 设置透明的 navigationBar
 */
- (void)setTransparentNavigationBar;

/**
 隐藏导航栏
 */
- (void)hideNavigationBar;

/**
 页面 push 跳转
 
 @param viewController 目标 VC
 @param isHidden 是否隐藏 tabBar
 @param animated 是否动画
 */
- (void)st_pushViewController:(nonnull UIViewController *)viewController needHideBottomBar:(BOOL)isHidden animated:(BOOL)animated;

/**
 页面 present 跳转
 
 @param viewController 目标 VC
 @param animated 是否动画
 @param completion 完成时的回调
 */
- (void)st_presentViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 pop 当前 VC
 
 @param animated 是否有动画
 @param complete 完成时的回调
 */
- (UIViewController *)st_popViewControllerAnimated:(BOOL)animated complete:(void (^)(BOOL finished))complete;

/**
 pop 到 Root VC
 */
- (NSArray <__kindof UIViewController *> *)st_popToRootViewControllerAnimated:(BOOL)animated
                                                                     complete:(void (^)(BOOL))block;



/**
 跳转登录页面
 */
- (void)showLoginPage;


-(void)ConfigBlackStatusColor;
-(void)ConfigLightStatusColor;

@end

NS_ASSUME_NONNULL_END
