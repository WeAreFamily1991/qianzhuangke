//
//  DRGuangGaoView.h
//  Shop
//
//  Created by BWJ on 2019/4/17.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRGuangGaoView : UICollectionReusableView
/* 轮播图数组 */
@property (copy , nonatomic)NSArray *imageGroupArray;

@property (copy,nonatomic) void (^ManageIndexBlock) (NSInteger ManageIndexBlock);

@property (strong,nonatomic)UILabel *titleLab;
@end

NS_ASSUME_NONNULL_END
