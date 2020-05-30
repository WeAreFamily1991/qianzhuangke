//
//  CRContentView.h
//  CRShopDetailDemo
//
//  Created by roger wu on 19/04/2018.
//  Copyright © 2018 cocoaroger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRDetailModel;
@class DRShopHeadModel;
@class DRNullGoodModel;
@protocol CRContentViewDelegate;

/**
 内容承载视图
 */
@interface CRContentView : UITableView

/**
 统一初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
              contentDelegate:(id<CRContentViewDelegate>)contentDelegate
                  detailModel:(CRDetailModel *)detailModel ShopHeadModel:(DRShopHeadModel *)shopHeadModel nullGoodModel:(DRNullGoodModel*)nullGoodModel withSellID:(NSString *)sellerId;

@end

@protocol CRContentViewDelegate <NSObject>

/**
 返回监听到的内容scrollView.contentOffset.y
 
 @param offsetY scrollView.contentOffset.y
 */
- (void)contentView:(CRContentView *)contentView offsetY:(CGFloat)offsetY;

@end
