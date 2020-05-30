//
//  DRAirCloudShopVC.h
//  Shop
//
//  Created by rockding on 2019/12/25.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRNullGoodModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRAirCloudShopVC : STBaseViewController
@property (nonatomic,strong)DRNullGoodModel *nullGoodModel;
@property (nonatomic,strong)NSString *sellerId,*nameStr;
@property (nonatomic,strong)NSString  * isAirCloud;
@end

NS_ASSUME_NONNULL_END
