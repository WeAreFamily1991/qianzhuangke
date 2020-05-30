//
//  GoodsCell.h
//  Shop
//
//  Created by BWJ on 2019/4/2.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "DRSameModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *cangkuLab;
@property (weak, nonatomic) IBOutlet UIButton *ziyingBtn;
@property (weak, nonatomic) IBOutlet UILabel *ziyingpeisongLab;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectShopBtn;
@property (weak, nonatomic) IBOutlet UILabel *kaipiaoLab;
@property (weak, nonatomic) IBOutlet UILabel *jiesuanLab;
@property (weak, nonatomic) IBOutlet UIButton *quanBtn;
@property (nonatomic, copy) dispatch_block_t selectlickBlock;
@property (nonatomic, copy) dispatch_block_t selectShopBtnBlock;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,retain)NSString *sellTypeCodeStr;
@end

NS_ASSUME_NONNULL_END
@interface GoodsCell1 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *cangkuLab;
@property (weak, nonatomic) IBOutlet UIButton *ziyingBtn;
@property (weak, nonatomic) IBOutlet UILabel *ziyingpeisongLab;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UILabel *jiesuanLab;
@property (weak, nonatomic) IBOutlet UIButton *quanBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectShopBtn;
@property (nonatomic, copy) dispatch_block_t selectlickBlock;
@property (nonatomic, copy) dispatch_block_t selectShopBtnBlock;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)NSString *sellTypeCodeStr;
@end
