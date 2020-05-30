//
//  SaleOrderCell.h
//  Shop
//
//  Created by BWJ on 2019/2/26.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillApplicationModel.h"
@class SalesOrderModel;
NS_ASSUME_NONNULL_BEGIN

@interface SaleOrderCell : UITableViewCell
/* 模型数据 */
@property (strong , nonatomic)SalesOrderModel *saleModel;
@property (strong , nonatomic)SalesOrderModel *shoukuanModel;
@property(nonatomic,assign)NSInteger status;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *getTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyCountLab;
@property (nonatomic, copy) dispatch_block_t detailClickBlock;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end



@interface SaleOrderCell1 : UITableViewCell
@property (strong , nonatomic)SalesOrderModel *saleModel;
@property(nonatomic,assign)NSInteger status;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *getTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (nonatomic, copy) dispatch_block_t detailClickBlock;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface SaleOrderCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnBackBtn;
@property (copy,nonatomic) void (^BtntagBlock) (NSInteger Btntag);
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface SaleOrderCell3 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

@interface SaleOrderCell4 : UITableViewCell
@property (strong , nonatomic)SalesOrderModel *saleModel;
@property(nonatomic,assign)NSInteger status;
@property (weak, nonatomic) IBOutlet UILabel *payLab;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *getTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLab;
@property (weak, nonatomic) IBOutlet UILabel *yunfeiLab;
@property (weak, nonatomic) IBOutlet UILabel *shopMoneyLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UILabel *duizhangCountLab;
@property (weak, nonatomic) IBOutlet UILabel *tansMoneyLab;
@property (nonatomic, copy) dispatch_block_t detailClickBlock;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end


@interface SaleOrderCell5 : UITableViewCell
@property (strong , nonatomic)SalesOrderModel *saleModel;
@property(nonatomic,assign)NSInteger status;
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UILabel *orderStstus;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *monenyLab;
@property (weak, nonatomic) IBOutlet UILabel *returnLab;
@property (weak, nonatomic) IBOutlet UILabel *canKPMoneyLab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (nonatomic, copy) dispatch_block_t detailClickBlock;
@property (nonatomic,strong) ShoppingModel *shoppingModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
NS_ASSUME_NONNULL_END
