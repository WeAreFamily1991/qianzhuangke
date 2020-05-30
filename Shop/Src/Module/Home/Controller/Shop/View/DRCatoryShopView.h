//
//  DRCatoryShopView.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRDetailModel;
@class DRShopHeadModel;
@class DRNullGoodModel;
@protocol DRCatoryShopViewDelegate;
NS_ASSUME_NONNULL_BEGIN

@interface DRCatoryShopView : UITableView

/**
 统一初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
              contentDelegate:(id<DRCatoryShopViewDelegate>)CatoryShopDelegate
                  detailModel:(CRDetailModel *)detailModel ShopHeadModel:(DRShopHeadModel *)shopHeadModel nullGoodModel:(DRNullGoodModel*)nullGoodModel withSellID:(NSString *)sellerId;

@end

@protocol DRCatoryShopViewDelegate <NSObject>

/**
 返回监听到的内容scrollView.contentOffset.y
 
 @param offsetY scrollView.contentOffset.y
 */
- (void)contentView:(DRCatoryShopView *)contentView offsetY:(CGFloat)offsetY;
@end

NS_ASSUME_NONNULL_END
