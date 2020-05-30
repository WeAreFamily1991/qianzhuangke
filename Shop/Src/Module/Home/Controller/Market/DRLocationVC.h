//
//  DRLocationVC.h
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRFactoryModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRLocationVC : STBaseViewController
@property (nonatomic,retain)NSString *advType;
@property (nonatomic,retain)NSString *type;
@property (nonatomic,retain)NSString *isHome;
/* 品牌数据 */
@property (retain , nonatomic)DRFactoryModel *factoryModel;
@end

NS_ASSUME_NONNULL_END
