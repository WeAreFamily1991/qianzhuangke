//
//  DRCuxiaoCell.h
//  Shop
//
//  Created by BWJ on 2019/4/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRCuXiaoModel;
@interface DRCuxiaoCell : UICollectionViewCell
{
    float Height;
}
/**
 The backView.
 */
@property (nonatomic, strong) UIView *backView;
/**
 The tilte Label.
 */
@property (nonatomic, strong) UILabel *btnTitle;

/**
 The tilte ImageView.
 */
@property (nonatomic, strong) UIButton *btnImage;

/**
 The imageURL string.
 */
@property (nonatomic, copy) NSString *imageURLString;

/**
 The titleString
 */
@property (nonatomic, copy) NSString *titleString;

/**
 The titleColor default #343434.
 */
@property (nonatomic, copy) NSString *titleColor;

@property (nonatomic,retain)NSString *shopStr;
/* 推荐数据 */
@property (strong , nonatomic)DRCuXiaoModel *cuxiaoModel;

@property (strong , nonatomic)UIButton *sameButton;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
///* 图片 */
//@property (strong , nonatomic)UIImageView *nullImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

@property (strong , nonatomic)UIView *lineView;


/** 比价格点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;
/** 进入店铺点击回调 */
@property (nonatomic, copy) dispatch_block_t centerShopBtnBlock;
/** 立即购买点击回调 */
@property (nonatomic, copy) dispatch_block_t sureBuyBtnBlock;
@end

NS_ASSUME_NONNULL_END
