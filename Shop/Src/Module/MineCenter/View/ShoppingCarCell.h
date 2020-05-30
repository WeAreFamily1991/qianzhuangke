//
//  ShoppingCarCell.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillApplicationModel.h"

#import "AddNumberView.h"
#import "LineLabel.h"
#import "DDButton.h"
@protocol ShoppingCarCellDelegate;
@interface ShoppingCarCell : UITableViewCell<AddNumberViewDelegate>


@property (nonatomic,strong) UIButton;

@property (nonatomic,strong) DDButton *selectBtn;
@property (nonatomic,strong) UILabel *orderNameLab;//单据编码
@property (nonatomic,strong) UILabel *orderLab;//单据编码
@property (nonatomic,strong) UILabel *timeNameLab;
@property (nonatomic,strong) UILabel *timeLab;//单据时间
@property (nonatomic,strong) UILabel *orderNamePriceLab;
@property (nonatomic,strong) UILabel *orderPriceLab;//单据金额
@property (nonatomic,strong) UILabel *backNamePriceLab;
@property (nonatomic,strong) UILabel *backPriceLab;//退货金额
@property (nonatomic,strong) UILabel *numberNameLab;
@property (nonatomic,strong) UILabel *numberLab;//可开票金额
@property (nonatomic,strong) UILabel *typeRightNameLab;
@property (nonatomic,strong) UILabel *typeRightLab;//可开票
@property (nonatomic,strong) UIButton *detailBtn;//查看详情

@property (nonatomic,strong) ShoppingModel *shoppingModel;
@property (nonatomic, strong) NSIndexPath *indexPath;//cell对应的indexPath
@property (nonatomic, assign) BOOL select;//是否是选中对应的商品
/** detail点击回调 */
@property (nonatomic, copy) dispatch_block_t selectClickBlock;
@property (assign,nonatomic) BOOL selectState;//选中状态

@property (nonatomic,assign) id<ShoppingCarCellDelegate>delegate;

//@property (nonatomic,strong) AddNumberView *addNumberView;
@end

@protocol ShoppingCarCellDelegate

- (void)cell:(ShoppingCarCell *)cell selected:(BOOL)isSelected indexPath:(NSIndexPath *)indexPath;

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end
