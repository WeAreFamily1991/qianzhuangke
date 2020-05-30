//
//  CRHomeView.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRSegmentItemBase.h"
#import "DRNullShopModel.h"
@class CRDetailModel;
@class DRNullGoodModel;
@class ViewController;
@class DCRecommendItem;
@protocol CRHomeViewDelegate;
/**
 首页
 */
@interface CRHomeView : CRSegmentItemBase

@property (copy, nonatomic) NSString *homeURL;
@property (copy, nonatomic)CRDetailModel *detailModel;
@property (strong, nonatomic) DRNullGoodModel *nullGoodModel;
@property (copy, nonatomic) NSString *sellerId;
@property (copy, nonatomic) ViewController *VC;
@property (nonatomic, copy) void (^selectedBlock)(NSInteger selectIndex);
/* 推荐商品属性 */
@property (strong , nonatomic)NSArray<DCRecommendItem *> *youLikeItem;
@property (nonatomic, weak) id<CRHomeViewDelegate> delegate;
@end

@protocol CRHomeViewDelegate <NSObject>
/**
 点击banner
 */
- (void)bannerShopModelClickedHome:(DRNullShopModel *)nullShopModel;
/**
 点击大家都在买
 */
- (void)allbuyShopModelClickedHome:(DRNullShopModel *)nullShopModel;
/**
 点击产品首页
 */
- (void)nullShopModelClickedHome:(DRNullShopModel *)nullShopModel;
/**
 点击产品分类
 */
- (void)youLikeModelClickedCGood:(DCRecommendItem *)youLikeModel;

@end
