//
//  DCGoodsSortCell.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCClassGoodsItem.h"
#import "DRCatoryModel.h"
@class DCClassMianItem;

@interface DCGoodsSortCell : UICollectionViewCell

/* 品牌数据 */
@property (strong , nonatomic)DCClassMianItem *mainItem;
@property (strong , nonatomic)ChildList *childModel;

@property (strong , nonatomic)SmallList *smallModel;
@end
