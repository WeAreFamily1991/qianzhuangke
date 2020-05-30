//
//  DRShopHeadView.h
//  Shop
//
//  Created by BWJ on 2019/4/22.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShopHeadView : UICollectionReusableView
/* title */
@property (strong , nonatomic)UILabel *titleLab;
/* 更多 */
@property (strong , nonatomic)UIButton *moreBtn;

@property (nonatomic, copy) dispatch_block_t moreBtnBlock;
@end

NS_ASSUME_NONNULL_END
