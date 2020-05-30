//
//  DRShopUserCell.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShopUserCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UIButton *getBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
/** 立即购买点击回调 */
@property (nonatomic, copy) dispatch_block_t getBtnBlock;
@end

NS_ASSUME_NONNULL_END
