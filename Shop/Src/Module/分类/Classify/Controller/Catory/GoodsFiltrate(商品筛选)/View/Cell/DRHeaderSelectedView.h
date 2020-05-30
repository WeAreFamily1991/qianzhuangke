//
//  DRHeaderSelectedView.h
//  Shop
//
//  Created by BWJ on 2019/5/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRHeaderSelectedView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *SelectBtn;
/** 头部点击 */
@property (nonatomic, copy) dispatch_block_t sectionClick;
@end

NS_ASSUME_NONNULL_END
