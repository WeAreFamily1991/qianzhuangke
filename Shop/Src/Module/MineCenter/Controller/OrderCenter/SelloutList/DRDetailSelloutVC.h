//
//  DRDetailSelloutVC.h
//  Shop
//
//  Created by BWJ on 2019/5/29.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRSellAfterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRDetailSelloutVC : STBaseViewController

@property (nonatomic,retain)NSString *returnId;
@property (nonatomic,strong)dispatch_block_t cancelBtnBlock;
@end

NS_ASSUME_NONNULL_END
