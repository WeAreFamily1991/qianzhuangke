//
//  DRSellerCell.h
//  StretchTableView
//
//  Created by BWJ on 2019/5/21.
//  Copyright © 2019 田相强. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DRComeModel;
@interface DRSellerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (nonatomic,retain)DRComeModel *comModel;
@end

NS_ASSUME_NONNULL_END
