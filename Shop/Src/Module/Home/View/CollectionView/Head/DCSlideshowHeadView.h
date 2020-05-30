//
//  DCSlideshowHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCSlideshowHeadView : UICollectionReusableView

/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;


/* 店铺轮播图数组 */
@property (copy , nonatomic)NSArray *imageShopGroupArray;

@property (copy,nonatomic) void (^ManageIndexBlock) (NSInteger ManageIndexBlock);
@end
