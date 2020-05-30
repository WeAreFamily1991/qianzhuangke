//
//  FifthCell.h
//  Shop
//
//  Created by BWJ on 2019/5/30.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AfterSellInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FifthCell : UITableViewCell<ATChooseCountDelegate>
{
    float Height;
}
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存
@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UILabel *danweiLab;     //单位
@property(nonatomic,strong)UILabel *allCountLabel;      ///小计
@property(nonatomic,strong)UIButton *saleOutBtn;      ///售后
@property(nonatomic,strong)NSDictionary *dataDict;      ///<数据
@property (nonatomic,strong)AfterSellList *goodModel;


@end

NS_ASSUME_NONNULL_END
