//
//  DCGoodsYouLikeCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

// Models
#import "DCRecommendItem.h"

@interface DCGoodsYouLikeCell : UICollectionViewCell
{
    float Height;
}
/* 推荐数据 */
@property (strong , nonatomic)ItemList *youLikeItem;
@property(nonatomic,strong)UIView *standardView;     ///<规格
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;
/* 进入店铺 */
@property (strong , nonatomic)UIButton *centerShopBtn;
/* 立即购买 */
@property (strong , nonatomic)UIButton *sureBuyBtn;

/** 比价格点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;
/** 进入店铺点击回调 */
@property (nonatomic, copy) dispatch_block_t centerShopBtnBlock;
/** 立即购买点击回调 */
@property (nonatomic, copy) dispatch_block_t sureBuyBtnBlock;

@end
