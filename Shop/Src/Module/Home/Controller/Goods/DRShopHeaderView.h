//
//  DRShopHeaderView.h
//  Shop
//
//  Created by BWJ on 2019/5/5.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRShopHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *IconIMG;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (nonatomic,copy)dispatch_block_t backBtnClickBlock;

@end

NS_ASSUME_NONNULL_END
