//
//  DCClassCategoryCell.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCClassGoodsItem;
@class DRCatoryModel;
@interface DCClassCategoryCell : UITableViewCell

/* 标题数据 */
@property (strong , nonatomic)DCClassGoodsItem *titleItem;

@property (strong , nonatomic)DRCatoryModel *airCloudItem;

@end
