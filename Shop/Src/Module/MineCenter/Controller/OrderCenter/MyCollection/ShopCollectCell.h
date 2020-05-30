//
//  ShopCollectCell.h
//  Shop
//
//  Created by rockding on 2020/3/27.
//  Copyright © 2020 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoriteModel;
NS_ASSUME_NONNULL_BEGIN

@interface ShopCollectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UILabel *ContentLab;
@property (nonatomic,retain)FavoriteModel *favorteModel;
@property (nonatomic,retain)dispatch_block_t cancelBlock;
@property (nonatomic,retain)dispatch_block_t callPhoneBlock;
@end

NS_ASSUME_NONNULL_END
