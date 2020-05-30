//
//  SellAfterFooterView.h
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SellAfterFooterView : UIView
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
/** 选择提交回调 */
@property (nonatomic, copy) dispatch_block_t submitBtnBlock;
/** 选择取消回调 */
@property (nonatomic, copy) dispatch_block_t cancelBtnBlock;
@end

NS_ASSUME_NONNULL_END
