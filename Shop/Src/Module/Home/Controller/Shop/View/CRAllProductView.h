//
//  CRAllProductView.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRSegmentItemBase.h"
@class CRDetailModel;
@class DRNullGoodModel;
@protocol CRAllProductViewDelegate;
/**
 全部宝贝
 */
@interface CRAllProductView : CRSegmentItemBase

@property (strong, nonatomic) CRDetailModel *model;
@property (strong, nonatomic) DRNullGoodModel *nullGoodModel;
@property (copy, nonatomic) NSString *sellerId;
@property (nonatomic, weak) id<CRAllProductViewDelegate> delegate;
@end

@protocol CRAllProductViewDelegate <NSObject>

/**
 点击产品首页
 */
- (void)nullShopModelClickedHome:(DRNullGoodModel *)nullShopModel;

@end
