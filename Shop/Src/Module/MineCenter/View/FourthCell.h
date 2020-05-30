//
//  FourthCell.h
//  Shop
//
//  Created by BWJ on 2019/3/20.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskSellOutModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FourthCell : UITableViewCell<ATChooseCountDelegate>
{
    float Height;
}
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productType;     ///<产品类型
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)ATChooseCountView *chooseCountView;     //输入框加减
@property(nonatomic,strong)UILabel *danweiLab;     //单位
@property(nonatomic,strong)UILabel *allCountLabel;      ///小计
@property(nonatomic,strong)UIButton *saleOutBtn;      ///售后
@property(nonatomic,strong)NSDictionary *dataDict;      ///<数据
@property (nonatomic,strong)GoodModel *goodModel;
@property (nonatomic,strong)AskSellOutModel *sellOutModel;
@property (nonatomic, copy) dispatch_block_t saleOutClickBlock;
@property (nonatomic, copy) NSString *numStr;
@property (copy,nonatomic) void (^numberBlock) (NSString *numberStr,NSInteger selectRow);
@property(nonatomic,assign)NSInteger selectRow;
@end

NS_ASSUME_NONNULL_END
