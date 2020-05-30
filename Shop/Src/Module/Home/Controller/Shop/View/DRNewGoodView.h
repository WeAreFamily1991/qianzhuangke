//
//  DRNewGoodView.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRSegmentItemBase.h"
@class CRDetailModel;
@class DRNullGoodModel;
@protocol DRNewGoodViewDelegate;
@interface DRNewGoodView : CRSegmentItemBase
@property (strong, nonatomic) CRDetailModel *model;
@property (copy, nonatomic) NSString *homeURL;
@property (strong, nonatomic) DRNullGoodModel *nullGoodModel;
@property (copy, nonatomic) NSString *sellerId;
@property (nonatomic, weak) id<DRNewGoodViewDelegate> delegate;
@end

@protocol DRNewGoodViewDelegate <NSObject>

/**
 点击产品首页
 */
- (void)nullShopModelClickedHome:(DRNullGoodModel *)nullShopModel;

@end
