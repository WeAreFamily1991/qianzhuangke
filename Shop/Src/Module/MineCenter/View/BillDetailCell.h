//
//  BillDetailCell.h
//  Shop
//
//  Created by BWJ on 2019/3/28.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillMessageDetailModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BillDetailCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) dispatch_block_t detailClickBlock;
@property (nonatomic,retain)DetailListModel *listModel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLab;
@property (weak, nonatomic) IBOutlet UILabel *returnBackLab;
@property (weak, nonatomic) IBOutlet UILabel *realCountLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@end

NS_ASSUME_NONNULL_END
