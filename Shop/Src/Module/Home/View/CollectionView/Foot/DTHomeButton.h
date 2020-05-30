//
//  DTHomeButton.h
//  DTcollege
//
//  Created by 信达 on 2018/7/24.
//  Copyright © 2018年 ZDQK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCRecommendItem;
@interface DTHomeButton : UIButton
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

/* 推荐数据 */
@property (strong , nonatomic)DCRecommendItem *youLikeItem;
@property(nonatomic,strong)UIView *standardView;     ///<规格
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/* 进入店铺 */
@property (strong , nonatomic)UIButton *centerShopBtn;
/* 立即购买 */
@property (strong , nonatomic)UIButton *sureBuyBtn;

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 图片 */
@property (strong , nonatomic)UIImageView *nullImageView;

/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 老价格 */
@property (strong , nonatomic)UILabel *orderPriceLabel;

@property (strong , nonatomic)UIView *lineView;


/** 比价格点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;
/** 进入店铺点击回调 */
@property (nonatomic, copy) dispatch_block_t centerShopBtnBlock;
/** 立即购买点击回调 */
@property (nonatomic, copy) dispatch_block_t sureBuyBtnBlock;

/**
  Initialize frame with title and imageURLString.

 @param frame frame
 @param title buttonTitle
 @param imageURLString buttonIamgeURLString
 @return object of DTHomeButton
 */
- (instancetype)initWithFrame:(CGRect)frame
                    withTitle:(NSString *)title
           withImageURLString:(NSString *)imageURLString;



@end
