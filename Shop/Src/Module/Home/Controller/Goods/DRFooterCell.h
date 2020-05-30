//
//  DRFooterCell.h
//  Shop
//
//  Created by BWJ on 2019/6/12.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRSameModel;
@interface DRFooterCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UILabel *qidingliangLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLAb;
@property (weak, nonatomic) IBOutlet UIButton *lookIMGbTN;
@property (weak, nonatomic) IBOutlet UILabel *lookLab;
@property (weak, nonatomic) IBOutlet UILabel *imgLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (strong,nonatomic)dispatch_block_t lookIMGBtnBlock;
@end

NS_ASSUME_NONNULL_END
