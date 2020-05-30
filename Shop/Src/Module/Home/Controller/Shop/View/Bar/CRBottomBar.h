//
//  CRBottomBar.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CRBottomBarDelegate;

@interface CRBottomBar : UIView

@property (nonatomic, weak) id<CRBottomBarDelegate> delegate;

@end

@protocol CRBottomBarDelegate <NSObject>
/**
 点击产品首页
 */
- (void)bottomBarClickedHome:(CRBottomBar *)bottomBar;
/**
 点击产品分类
 */
- (void)bottomBarClickedCategory:(CRBottomBar *)bottomBar;
/**
 点击公司简介
 */
- (void)bottomBarClickedpinpai:(CRBottomBar *)bottomBar;
/**
 点击公司简介
 */
- (void)bottomBarClickedIntro:(CRBottomBar *)bottomBar;
@end
