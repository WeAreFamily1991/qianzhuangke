//
//  DRShopBannerCollectionViewCell.h
//  Shop
//
//  Created by BWJ on 2019/4/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN
@class DRFooterModel;
@interface DRShopBannerCollectionViewCell : UICollectionViewCell
{
    float Height;
}
/* 轮播图数组 */
@property (copy , nonatomic)NSArray *titleGroupArray;
@property (copy,nonatomic) void (^ManageIndexBlock) (NSInteger ManageIndexBlock);

@property(nonatomic,strong)UIImageView *productImg;  ///<产品图片
@property(nonatomic,strong)UILabel *productName;     ///<产品名称
@property(nonatomic,strong)UIView *standardView;     ///<规格
@property(nonatomic,strong)UILabel *parameterLabel;  ///<产品参数
@property(nonatomic,strong)UILabel *cellLabel;       ///<销售单位
@property(nonatomic,strong)UILabel *countLabel;      ///<库存
@property (nonatomic,retain)GoodsListModel *goodListModel;
@property (nonatomic,retain)GoodsModel *goodsModel;
@property (nonatomic,retain)DRFooterModel *footModel;
@property(nonatomic,strong)NSDictionary *dataDict;      ///<数据
@property(nonatomic,assign)NSInteger selectRow;
@property (strong , nonatomic)UIButton *quickButton;
@end

NS_ASSUME_NONNULL_END
