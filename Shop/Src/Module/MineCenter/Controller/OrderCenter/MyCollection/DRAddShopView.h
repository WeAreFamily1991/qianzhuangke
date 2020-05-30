//
//  DRAddShopView.h
//  Shop
//
//  Created by BWJ on 2019/4/11.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumberCalculate.h"
#import "GoodsModel.h"
#import "DRAddShopModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DRAddShopView : UIView<NumberCalculateDelegate>
+ (DRAddShopView *)getDRAddShopView;
@property (weak, nonatomic) IBOutlet UILabel *santieMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *otherMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *bACKvIEW;
@property (weak, nonatomic) IBOutlet NumberCalculate *numberTF;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *danweiLab;
@property (weak, nonatomic) IBOutlet UITextField *danweiTF;
@property (weak, nonatomic) IBOutlet UILabel *BZCSlAB;
@property (weak, nonatomic) IBOutlet UILabel *sjchsLab;
@property (weak, nonatomic) IBOutlet UILabel *qtyLab;
@property (nonatomic,retain)UIScrollView *upScrollView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, copy) dispatch_block_t closeclickBlock;
@property (nonatomic, copy) dispatch_block_t sureclickBlock;
@property (nonatomic , strong) UIButton * currentSelectedBtn ;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,assign)NSInteger selectBtnTag;
@property (assign,nonatomic)double selectcode;
@property (assign,nonatomic)NSString *selectID;
@property (assign,nonatomic)NSString * selectName;
@property (nonatomic,retain)NSString *countNumStr,*baseStr;
@property (nonatomic,strong)NSMutableArray *selectNameArr,*selectCodeArr,*selectIDArr;
@property (nonatomic,strong)NSArray *itemListArr;
@property (nonatomic,retain)DRAddShopModel *addshopModel;
-(void)show;
-(void)diss;
@end

NS_ASSUME_NONNULL_END
