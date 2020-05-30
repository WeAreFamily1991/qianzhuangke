//
//  DCTabBarController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTabBarController.h"

// Controllers

#import "ChangeOrderVC.h"
//#import "DCBeautyMessageViewController.h"
// Models

// Views
#import "DCTabBadgeView.h"
#import "UITabBar+Badge.h"
// Vendors

// Categories

// Others

@interface DCTabBarController ()<UITabBarControllerDelegate>



@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property (nonatomic, weak) UITabBarItem *item;

@end

@implementation DCTabBarController

#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
}

#pragma mark - LifeCyle

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 添加通知观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeValue) name:DCMESSAGECOUNTCHANGE object:nil];
    
    // 添加badgeView
    [self addBadgeViewOnTabBarButtons];
//
//    WEAKSELF
//    [[NSNotificationCenter defaultCenter] addObserverForName:LOGINOFFSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//        weakSelf.selectedViewController = [weakSelf.viewControllers objectAtIndex:DCTabBarControllerHome]; //默认选择商城index为1
//    }];

}
#pragma mark - initialize
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
   
    [self addDcChildViewContorller];
    
    self.selectedViewController = [self.viewControllers objectAtIndex:DCTabBarControllerHome]; //默认选择商城index为0
   
 
 
}
#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"DCHandPickViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"首页",
                              MallSelImgKey : @"首页-1"},
                            
                            @{MallClassKey  : @"DRBullDealerVC",
                              MallTitleKey  : @"爆品牛商",
                              MallImgKey    : @"爆品",
                              MallSelImgKey : @"爆品-1"},
                            
                            @{MallClassKey  : @"DCCommodityViewController",
                              MallTitleKey  : @"分类购买",
                              MallImgKey    : @"分类",
                              MallSelImgKey : @"分类-1"},
                            
                            @{MallClassKey  : @"ShoppingCartViewController",
                              MallTitleKey  : @"购物车",
                              MallImgKey    : @"购物车",
                              MallSelImgKey : @"购物车-1"},
                            
                            @{MallClassKey  : @"MineViewController",
                              MallTitleKey  : @"个人中心",
                              MallImgKey    : @"个人中心",
                              MallSelImgKey : @"个人中心-1"},
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
         vc.title =dict[MallTitleKey];
        DCNavigationController *nav = [[DCNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.image = [[UIImage imageNamed:dict[MallImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//         vc.tabBarItem.image = originalImage;
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
//        item.titlePositionAdjustment = UIOffsetMake(5, 0);
        //设置TabBarItem

    
        if (@available(iOS 13.0, *)) {
            // iOS 13以上
            self.tabBar.tintColor = REDCOLOR;
            self.tabBar.unselectedItemTintColor = RGBHex(0XB0B0B0);

            [item setTitleTextAttributes:@{NSFontAttributeName:DR_FONT(10)} forState:UIControlStateNormal];
            [item setTitleTextAttributes:@{NSFontAttributeName:DR_FONT(10)} forState:UIControlStateSelected];
        } else {
            // iOS 13以下
            NSMutableDictionary *textNormalDic = [NSMutableDictionary dictionary];
            textNormalDic[NSForegroundColorAttributeName] = RGBHex(0XB0B0B0);
            textNormalDic[NSFontAttributeName] = DR_FONT(10);
            
            NSMutableDictionary *textSelectedDic = [NSMutableDictionary dictionary];
            textSelectedDic[NSForegroundColorAttributeName] = REDCOLOR;
            textSelectedDic[NSFontAttributeName] = DR_FONT(10);
            
            [item setTitleTextAttributes:textNormalDic forState:UIControlStateNormal];
            [item setTitleTextAttributes:textSelectedDic forState:UIControlStateSelected];
        }
        if (idx==3) {
             [self.tabBar updateBadge:@"120" bgColor:[UIColor purpleColor] atIndex:0];
            [self.tabBar updateBadgeTextColor:[UIColor redColor] atIndex:0];

        }
        
        self.tabBar.barTintColor=WHITECOLOR;
        self.tabBar.translucent = YES; //这句表示取消tabBar的透明效果。
        [self addChildViewController:nav];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor = BACKGROUNDCOLOR;
        [[UITabBar appearance] insertSubview:view atIndex:0];
//        CGRect rect = CGRectMake(0, 0, ScreenW, ScreenW);
//
//        UIGraphicsBeginImageContext(rect.size);
//
//        CGContextRef context = UIGraphicsGetCurrentContext();
//
//        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//
//        CGContextFillRect(context, rect);
//
//        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//
//        UIGraphicsEndImageContext();
//
//        [self.tabBar setBackgroundImage:img];
//
//        [self.tabBar setShadowImage:img];
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
}
#pragma mark - 控制器跳转拦截
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if(viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerBeautyStore]||viewController == [tabBarController.viewControllers objectAtIndex:DCTabBarControllerPerson]){        
        if (![User currentUser].isLogin) {
            [DRAppManager showLoginView];
            return NO;
        }
    }
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if ([self.childViewControllers.firstObject isEqual:viewController]) { //根据tabBar的内存地址找到美信发通知jump
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
    }
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];

    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}

#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}


#pragma mark - 更新badgeView
- (void)updateBadgeValue
{
//    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
}


#pragma mark - 添加所有badgeView
- (void)addBadgeViewOnTabBarButtons {
    
    // 设置初始的badegValue
//    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
    
    int i = 0;
    for (UITabBarItem *item in self.tabBarItems) {
        
        if (i == 0) {  // 只在美信上添加
            [self addBadgeViewWithBadgeValue:item.badgeValue atIndex:i];
            // 监听item的变化情况
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
            _item = item;
        }
        i++;
    }
}

- (void)addBadgeViewWithBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    
    DCTabBadgeView *badgeView = [DCTabBadgeView buttonWithType:UIButtonTypeCustom];
    
    CGFloat tabBarButtonWidth = self.tabBar.dc_width / self.tabBarItems.count;
    
    badgeView.dc_centerX = index * tabBarButtonWidth + 40;
    
    badgeView.tag = index + 1;
    
    badgeView.badgeValue = badgeValue;
    
    [self.tabBar addSubview:badgeView];
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[DCTabBadgeView class]]) {
            if (subView.tag == 1) {
                DCTabBadgeView *badgeView = (DCTabBadgeView *)subView;
//                badgeView.badgeValue = _beautyMsgVc.tabBarItem.badgeValue;
            }
        }
    }
}
#pragma mark - 移除通知
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}

@end
