//
//  CRConst.h
//  CRShopDetailDemo
//
//  Created by roger wu on 18/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CRMacro.h"

// 局部常量
static NSString * const kToTopNotification = @"kToTopNotification"; // segment 置顶通知
static NSString * const kLeaveTopNotification = @"kLeaveTopNotification"; // segment 离开置顶通知
static const CGFloat kBottomBarHeight = 44; // 底部高度
static const CGFloat kSegmentHeight = 44; // 分割栏高度
static const CGFloat kSortBarHeight = 40; // 排序高度
static const NSInteger kDefaulpageSize = 20; // 默认页数
static const CGFloat kLineHeight44 = 44;
static const CGFloat kNavigationBarHeight88 = 88;
static const CGFloat kNavigationBarHeight64 = 64;
static const CGFloat kSafeAreaLayoutGuideBottomHeight = 34;

#define kSeperatorLineHeight CGFloatFromPixel(1)

#define kMainColor rgba(255, 101, 0, 1)
#define kPlaceholderColor rgba(213, 213, 213, 1)
#define kBlackColor rgba(51, 51, 51, 1)
#define kSeperatorLineColor rgba(227,227,227,1)
#define kLightGrayColor rgba(153,153,153,1)
#define kBackgroundColor rgba(245,245,245,1)
#define kImageBackgroundColor rgba(230,230,230,1)

@interface CRConst : NSObject

+ (CGFloat)kHeaderViewHeight;

@end
