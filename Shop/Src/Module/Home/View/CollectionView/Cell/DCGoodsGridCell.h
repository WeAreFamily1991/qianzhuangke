//
//  DCGoodsGridCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class DCGridItem;
@class DCRecommendItem;
@interface DCGoodsGridCell : UICollectionViewCell

/* 10个属性数据 */
//@property (strong , nonatomic)DCGridItem *gridItem;
@property (strong , nonatomic)DCRecommendItem *youLikeItem;
@end
