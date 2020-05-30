//
//  FirstTableViewCell.h
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "AskSellOutModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ThirdCell : UITableViewCell
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
@property(nonatomic,strong)UILabel *allCountLabel;      ///小计
@property(nonatomic,strong)UIView *lineView;      ///小计
@property(nonatomic,strong)UIView *linebView;      ///小计
@property(nonatomic,strong)UIButton *saleOutBtn;      ///售后
@property (nonatomic,retain)GoodsListModel *goodListModel;
@property (nonatomic,retain)OrderModel *orderModel;
@property (nonatomic,retain)GoodModel *goodModel;
@property (nonatomic,retain)AskSellOutModel *sellOutModel;
@property (nonatomic, copy) dispatch_block_t saleOutClickBlock;
@end

NS_ASSUME_NONNULL_END
