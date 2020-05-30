//
//  FirstTableViewCell.h
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "OrderModel.h"
#import "DRSellAfterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstTableViewCell : UITableViewCell
{
    float HeightF;
}
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productType;     ///<产品类型
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存
@property(nonatomic,strong)UILabel *moneyLabel;      ///<单价
@property (nonatomic,retain)GoodsListModel *goodListModel;
@property (nonatomic,retain)GoodsList *goodSellOutModel;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property(nonatomic,strong)NSDictionary *dataDict;      ///<数据
@property(nonatomic,assign)NSInteger selectRow;
@end

NS_ASSUME_NONNULL_END
