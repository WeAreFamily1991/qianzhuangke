//
//  CatgoryDetailCell.h
//  Shop
//
//  Created by BWJ on 2019/3/7.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"
#import "GoodsModel.h"
#import "DRSameModel.h"
#import "ATChooseCountView.h"
//@class CarDetailModel;

NS_ASSUME_NONNULL_BEGIN


@interface CatgoryDetailCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UIView *numberview;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (nonatomic,retain)NSString *queryTypeStr;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,retain)NSString *favoriteID;
@property (nonatomic,retain)NSString *titleStr;
@property (copy,nonatomic) void (^cancelBlock) (NSInteger canceltag);
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@property (copy,nonatomic) void (^noticeBlock) (NSInteger noticeTag);
@property (nonatomic,retain)dispatch_block_t moreBtnBlock;
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,strong)NSString *shoucangStr;
@property (nonatomic,strong)NSString *daohuoTongzhiStr;
@property (nonatomic,retain)NSMutableDictionary *sourceDic;
@end

@protocol CatgoryDetailCellSelectDelegate <NSObject>
/** 增减数量按钮点击事件 */
- (void)changeShopCount:(UIButton *)sender;
/** 手动输入数量 */
- (void)tableViewScroll:(UITextField *)textField;

@end
@interface CatgoryDetailCell1 : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;
//@property (nonatomic, strong) CarDetailModel *goodsModel;
//@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UIView *numberview;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (copy,nonatomic) void (^danweiBtnBlock) (NSInteger danweiBtntag);
@property (nonatomic, weak) id<CatgoryDetailCellSelectDelegate>delegate;
@property (nonatomic,retain)NSString *queryTypeStr;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,strong)NSMutableArray *selectNameArr,*selectCodeArr,*selectDanweiArr;
@property (assign,nonatomic)double selectcode;
@property (assign,nonatomic)NSString *selectDanWei;
@property (assign,nonatomic)NSString * selectName;
@property (nonatomic,retain)NSString *countNumStr;
@property (nonatomic,retain)NSMutableDictionary *sourceDic;
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,strong)NSString *shoucangStr;
@property (copy,nonatomic) void (^cancelBlock) (NSInteger canceltag);
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@property (copy,nonatomic) void (^noticeBlock) (NSInteger noticeTag);
@property (nonatomic,retain)dispatch_block_t moreBtnBlock;
@end

NS_ASSUME_NONNULL_END

@interface CatgoryDetailCell2 : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath;
//@property (nonatomic, strong) CarDetailModel *goodsModel;
//@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIButton *danweiBtn;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UIView *numberview;

@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (copy,nonatomic) void (^danweiBtnBlock) (NSInteger danweiBtntag);
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,strong)NSString *shoucangStr;
@property (copy,nonatomic) void (^cancelBlock) (NSInteger canceltag);
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@property (copy,nonatomic) void (^noticeBlock) (NSInteger noticeTag);
@property (nonatomic, weak) id<CatgoryDetailCellSelectDelegate>delegate;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,strong)NSMutableArray *selectNameArr,*selectCodeArr,*selectDanweiArr;
@property (assign,nonatomic)double selectcode;
@property (assign,nonatomic)NSString *selectDanWei;
@property (assign,nonatomic)NSString * selectName;
@property (nonatomic,retain)NSString *countNumStr;
@property (nonatomic,retain)NSMutableDictionary *sourceDic;

@end


@interface CatgoryDetailCell3 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,retain)NSString *favoriteID;
@property (nonatomic,retain)NSString *titleStr;
@property (copy,nonatomic) void (^cancelBlock) (NSInteger canceltag);
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@property (copy,nonatomic) void (^noticeBlock) (NSInteger noticeTag);
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,strong)NSString *shoucangStr;
@property (nonatomic,strong)NSString *daohuoTongzhiStr;
@property (nonatomic,retain)NSMutableDictionary *sourceDic;
@end



@interface CatgoryDetailCell4 : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceAccountLab;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLab;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRSameModel *sameModel;
@property (nonatomic,retain)NSString *favoriteID;
@property (nonatomic,retain)NSString *titleStr;
@property (copy,nonatomic) void (^cancelBlock) (NSInteger canceltag);
@property (copy,nonatomic) void (^shoucangBlock) (NSInteger shoucangtag);
@property (copy,nonatomic) void (^shopCarBlock) (NSInteger shopCartag);
@property (copy,nonatomic) void (^noticeBlock) (NSInteger noticeTag);
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,strong)NSString *shoucangStr;
@property (nonatomic,strong)NSString *daohuoTongzhiStr;
@property (nonatomic,retain)NSMutableDictionary *sourceDic;
@end
