//
//  MineCell.h
//  Shop
//
//  Created by BWJ on 2019/2/19.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YeeBadgeViewHeader.h"
#import "DROrderCountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UIButton *dealOrderBtn;
@property (weak, nonatomic) IBOutlet UIImageView *daifuIMG;
@property (weak, nonatomic) IBOutlet UIImageView *daishenIMG;
@property (weak, nonatomic) IBOutlet UIImageView *daifaIMG;
@property (weak, nonatomic) IBOutlet UIImageView *daishouIMG;
@property (weak, nonatomic) IBOutlet UIImageView *shouhouIMG;
@property (weak, nonatomic) IBOutlet UIButton *aftersaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrivalnoticeBtn;
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *diyongBtn;
@property (retain,nonatomic)DROrderCountModel *countModel;
@property (copy,nonatomic) void (^BtnManagetagBlock) (NSInteger manageBtntag);
@property (strong,nonatomic)dispatch_block_t setBtnClickBlock;
-(void)configueCellBadgeStyle:(YeeBadgeStytle)style;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface MineCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *shopOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *kaipiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *shenqingBtn;
@property (weak, nonatomic) IBOutlet UIButton *jiluBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoukuanBtn;
@property (copy,nonatomic) void (^BtnMoneytagBlock) (NSInteger moneyBtntag);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface MineCell3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *kefuBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *personBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePWBtn;
@property (weak, nonatomic) IBOutlet UIButton *shouhuoBtn;
@property (weak, nonatomic) IBOutlet UIButton *childBtn;
@property (weak, nonatomic) IBOutlet UIButton *guanlianBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (copy,nonatomic) void (^BtnOthertagBlock) (NSInteger otherBtntag);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface MineCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *groundView;
@property (weak, nonatomic) IBOutlet UIButton *kefuBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *personBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePWBtn;
@property (weak, nonatomic) IBOutlet UIButton *shouhuoBtn;
@property (weak, nonatomic) IBOutlet UIButton *guanlianBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (copy,nonatomic) void (^BtnOthertagBlock) (NSInteger otherBtntag);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
NS_ASSUME_NONNULL_END
