//
//  DRShopHomeVC.h
//  Shop
//
//  Created by rockding on 2019/12/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRNullGoodModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRShopHomeVC : STBaseViewController
@property(nonatomic,assign)NSInteger num;
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerId;
@property (nonatomic,strong)NSString *ycStr;
/** 搜索栏 */
@property (nonatomic, weak) UISearchBar *searchBar;
//默认上下左右放大
@property (nonatomic, assign) BOOL isEnlarge;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, readonly, assign) BOOL isBacking;
@property (nonatomic,strong)NSString  * isAirCloud;
@end

NS_ASSUME_NONNULL_END
