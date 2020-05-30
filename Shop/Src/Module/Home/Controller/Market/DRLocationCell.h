//
//  DRLocationCell.h
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRLocationModel;
@class FavoriteModel;
NS_ASSUME_NONNULL_BEGIN

@interface DRLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UIButton *titBtn;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *modelLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *nullImg;
@property (weak, nonatomic) IBOutlet UIImageView *quanIMG;
@property (nonatomic,retain)DRLocationModel *locationModel;
@property (nonatomic,retain)FavoriteModel *favorteModel;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (strong,nonatomic)dispatch_block_t collectionBtnBlock;
@end

NS_ASSUME_NONNULL_END
