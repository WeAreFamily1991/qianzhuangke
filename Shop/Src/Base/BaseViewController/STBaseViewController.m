//
//  STBaseViewController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "STBaseViewController.h"
#import "CoreLocation/CoreLocation.h"
@interface STBaseViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager*locationmanager;//定位服务
    NSString*strlatitude;//经度
    NSString*strlongitude;//纬度

}
@end

@implementation STBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // 导航栏默认设置
    [self defaultConfig];
    [self showLoginPage];
   
   
}
#pragma mark - 定位

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
/**
 默认配置
 */
-(void)defaultConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    // 去掉导航栏下面的线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:f_UIColorFromColor16(0x74b1f0, 1.0)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:BLACKCOLOR];
    [self ConfigBlackStatusColor];
}

-(void)ConfigBlackStatusColor{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)ConfigLightStatusColor
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
// 自定义返回按钮图片
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"santie_ico_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:action];
    return backItem;
}

#pragma mark - Public
/**
 设置 navigationBar 上面的字体为白色
 */
- (void)setWhiteNavigationBarTitle {
    // 隐藏 titleView
    self.navigationItem.titleView = nil;
    NSDictionary *attr = @{
                           NSFontAttributeName : BoldFont(WidthScale(34)),
                           NSForegroundColorAttributeName : [UIColor whiteColor]
                           };
    
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
}
// 设置透明的 navigationBar
- (void)setTransparentNavigationBar {
    // 由于使用了 RTNavigationController ，每个页面的 navigationBar 都是独立的，设置当前页面的导航栏不会影响其它页面
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    // 隐藏 titleView
    self.navigationItem.titleView = nil;
    // 导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES; // 在设置透明 navBar 时，translucent 必须为 YES（半透明），否则导航栏会显示白色
}

/**
 隐藏导航栏
 */
- (void)hideNavigationBar {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

// 页面 push 跳转
- (void)st_pushViewController:(nonnull UIViewController *)viewController needHideBottomBar:(BOOL)isHidden animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = isHidden;
    [self.rt_navigationController pushViewController:viewController animated:animated];
}

// 页面 present 跳转
- (void)st_presentViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion {
    [self.rt_navigationController presentViewController:viewController animated:animated completion:completion];
}

/**
 pop 当前 VC
 */
- (UIViewController *)st_popViewControllerAnimated:(BOOL)animated complete:(void (^)(BOOL))complete {
    return [self.rt_navigationController popViewControllerAnimated:animated complete:complete];
}

/**
 pop 到 Root VC
 */
- (NSArray <__kindof UIViewController *> *)st_popToRootViewControllerAnimated:(BOOL)animated
                                                                     complete:(void (^)(BOOL))block {
    return [self.rt_navigationController popToRootViewControllerAnimated:animated complete:block];
}

/**
 跳转登录页面
 */
- (void)showLoginPage {
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.modalPresentationStyle =UIModalPresentationFullScreen;
    [self st_presentViewController:loginVC animated:YES completion:nil];
}

#pragma mark - 通用设置
/**
 屏幕方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

/**
 状态栏样式 >=7.0
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 是否隐藏状态条 >=7.0
 */
- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
