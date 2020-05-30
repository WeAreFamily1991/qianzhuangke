//
//  LabelCell.h
//  LXTagsView
//
//  Created by 万众创新 on 2018/7/25.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
#import "GoodsModel.h"

@interface LabelCell : UITableViewCell
@property(nonatomic,strong)NSArray *items;
@property (nonatomic,retain)GoodsListModel *goodListModel;
@property (nonatomic,retain)GoodsListModel *goodSellOutModel;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productType;
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *countLabel;  ///<产品参数
@end
