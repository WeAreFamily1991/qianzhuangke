//
//  DRNullGoodLikesCell.h
//  Shop
//
//  Created by BWJ on 2019/4/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProgress.h"
#import "DRNullGoodModel.h"
#import "DRNullShopModel.h"
#import "DCRecommendItem.h"
NS_ASSUME_NONNULL_BEGIN
//@class DCRecommendItem;
@interface DRNullGoodLikesCell : UICollectionViewCell
{
    float Height;
     double present;
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
@property (strong , nonatomic)DRNullShopModel *nullShopModel;
/* 推荐数据 */
@property (strong , nonatomic)ItemList *youLikeItem;
@property (strong , nonatomic)DRNullGoodModel *nullGoodModel;
@property(nonatomic,strong)UIView *standardView;     ///<规格
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/* 相同 */
@property (strong , nonatomic)UIButton *addressBtn;

/* 进入店铺 */
@property (strong , nonatomic)UIButton *centerShopBtn;
/* 立即购买 */
@property (strong , nonatomic)UIButton *sureBuyBtn;

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 图片 */
@property (strong , nonatomic)UIImageView *nullImageView;
/* 图片 */
@property (strong , nonatomic)UIImageView *baoImageView;

/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 标题 */
@property (strong , nonatomic)UILabel *standedLabel;

@property (strong , nonatomic)UIButton *baokuanBtn;

@property (strong , nonatomic)UIButton *baokuanCountBtn;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 老价格 */
@property (strong , nonatomic)UILabel *orderPriceLabel;


@property (strong , nonatomic)UIView *lineView;
/* 剩余 */
@property (strong , nonatomic)UILabel *isHaveLabel;
@property (strong , nonatomic) CustomProgress *custompro;


/** 比价格点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;
/** 进入店铺点击回调 */
@property (nonatomic, copy) dispatch_block_t centerShopBtnBlock;
/** 立即购买点击回调 */
@property (nonatomic, copy) dispatch_block_t sureBuyBtnBlock;
@end

NS_ASSUME_NONNULL_END
