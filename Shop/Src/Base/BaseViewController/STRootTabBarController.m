//
//  STRootTabBarController.m
//  Shop
//
//  Created by BWJ on 2018/12/29.
//  Copyright © 2018 SanTie. All rights reserved.
//

#import "STRootTabBarController.h"

@interface STRootTabBarController ()

@end

@implementation STRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 去掉 TabBar 顶部的那条线
    [self hideTabBarTopLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

#pragma mark - Private

/**
 去掉 TabBar 顶部的那条线
 */
- (void)hideTabBarTopLine {
    UIImage *img = [Utility imageWithColor:[UIColor clearColor]];
    self.tabBar.shadowImage = img;
    self.tabBar.backgroundImage = img;
    // 必须要设置背景色，否则 tabBar 会变成透明的
    self.tabBar.backgroundColor = [UIColor whiteColor];
}

@end
