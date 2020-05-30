//
//  ChildCell.h
//  Shop
//
//  Created by BWJ on 2019/3/6.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRChildCountModel;
NS_ASSUME_NONNULL_BEGIN


@interface ChildCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameCountLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
/* 模型数据 */
@property (strong , nonatomic)DRChildCountModel *adItem;
/** 选择编辑回调 */
@property (nonatomic, copy) dispatch_block_t isEditBlock;
/** 选择启用回调 */
@property (nonatomic, copy) dispatch_block_t isStartBlock;
/** 选择删除回调 */
@property (nonatomic, copy) dispatch_block_t isCancelBlock;
@end
NS_ASSUME_NONNULL_END
