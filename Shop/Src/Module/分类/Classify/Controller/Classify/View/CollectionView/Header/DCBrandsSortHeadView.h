//
//  DCBrandsSortHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCClassGoodsItem.h"
#import "DRCatoryModel.h"
@class DCClassMianItem;
@interface DCBrandsSortHeadView : UICollectionReusableView

/* 头部标题 */
@property (strong , nonatomic)DCClassMianItem *headTitle;
@property (strong,nonatomic)ChildCategory2 *cateproyModel;
@property (strong,nonatomic)CatoryList *smallModel;
@property (retain,nonatomic)dispatch_block_t selectedBlock;

@end
