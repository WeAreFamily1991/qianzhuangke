//
//  DRFactoryCell.h
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRFactoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRFactoryCell : UICollectionViewCell
/* 品牌数据 */
@property (strong , nonatomic)DRFactoryModel *factoryModel;
@property (strong,nonatomic)NSString *titleStr;
@end

NS_ASSUME_NONNULL_END
