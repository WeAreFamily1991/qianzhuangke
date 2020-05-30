//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setDataDict:(NSDictionary *)dataDict
{
    self.productImg.image = [UIImage imageNamed:@"product"];
    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";

    NSArray * array =[NSArray array];
    if (_selectRow==1) {
            }
    else
    {
        array = @[@"M14-2.0*110",@" 12.9级",@"40Cr(合金钢)",@"淬黑",@"紧固之星"];

    }


    HeightF = WScale(30);
    [self setStandWithArray:array];

    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 ";
    //    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
    //    self.countLabel.text = @"库存数：72.0000支 华东仓";
}
-(void)setGoodListModel:(GoodsListModel *)goodListModel
{
    _goodListModel =goodListModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodListModel.itemName;
    NSArray * array = @[goodListModel.spec?:@"",goodListModel.levelName?:@"",goodListModel.materialName?:@"",goodListModel.surfaceName?:@"",goodListModel.brandName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr.copy];
    self.parameterLabel.text = [NSString stringWithFormat:@"购买数量：%.3f%@  小计：￥%.2f",goodListModel.qty,goodListModel.basicUnitName,goodListModel.realAmt];
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;

    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodsModel.itemName;
    NSArray * array = @[goodsModel.spec?:@"",goodsModel.levelName?:@"",goodsModel.materialName?:@"",goodsModel.surfaceName?:@"",goodsModel.brandName?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr];

    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([goodsModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodsModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodsModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    
    
    NSString *nameStr,*cellStr;
    if (goodsModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",goodsModel.unitConversion1,baseStr,goodsModel.unitName1];
        cellStr =goodsModel.unitName1;
    }
    if (goodsModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion2 ,baseStr,goodsModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitName2;

        }
    }
    if (goodsModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion3,baseStr,goodsModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitName3;

        }
    }
    if (goodsModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion4,baseStr,goodsModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitName4;

        }
    }
    if (goodsModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion5,baseStr,goodsModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitName5;

        }
    }

    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];;
    self.cellLabel.text =[NSString stringWithFormat:@"最小销售单位: %@  单规格起订量: %.3f%@",cellStr,goodsModel.minQuantity,cellStr] ;
    self.countLabel.text =[NSString stringWithFormat:@"库存数(%@): %.3f  %@",baseStr,goodsModel.qty,goodsModel.storeName] ;
}

-(void)setGoodSellOutModel:(GoodsList *)goodSellOutModel
{
    _goodSellOutModel =goodSellOutModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodSellOutModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    
    self.productName.text =goodSellOutModel.itemName;
    NSArray * array = @[goodSellOutModel.spec?:@"",goodSellOutModel.levelName?:@"",goodSellOutModel.materialName?:@"",goodSellOutModel.surfaceName?:@""];
    self.productType.text =goodSellOutModel.brandName;
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
        HeightF = WScale(30);
        [self setStandWithArray:titArr.copy];
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
//    if ([goodSellOutModel.basicUnitId intValue]==5) {
//        baseStr =@"千支";
//    }
//    if ([goodSellOutModel.basicUnitId intValue]==6) {
//        baseStr =@"公斤";
//    }
//    if ([goodSellOutModel.basicUnitId intValue]==7) {
//        baseStr =@"吨";
//    }
    baseStr=goodSellOutModel.basicUnitName;
    NSString *nameStr,*cellStr;
    if (goodSellOutModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",goodSellOutModel.unitConversion1,baseStr,goodSellOutModel.unitName1];
        cellStr =goodSellOutModel.unitName1;
    }
    if (goodSellOutModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion2,baseStr,goodSellOutModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName2;
            
        }
    }
    if (goodSellOutModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion3,baseStr,goodSellOutModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName3;
            
        }
    }
    if (goodSellOutModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion4,baseStr,goodSellOutModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName4;
            
        }
    }
    if (goodSellOutModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodSellOutModel.unitConversion5,baseStr,goodSellOutModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName5;            
        }
    }
    self.parameterLabel.text = [NSString stringWithFormat:@"包装参数：%@",nameStr?:@""];
    self.moneyLabel.text =[NSString stringWithFormat:@"价格：￥%.2f",goodSellOutModel.returnPrice];
    [SNTool setTextColor:self.moneyLabel FontNumber:DR_FONT(18) AndRange:NSMakeRange(3, self.moneyLabel.text.length-3) AndColor:REDCOLOR];
    
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.contentMode = UIViewContentModeScaleAspectFit;
        _productImg.backgroundColor =WHITECOLOR;
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(90));
            make.width.mas_equalTo(WScale(90));
        }];
    }
    return _productImg;
}

-(UILabel *)productType
{
    if (!_productType) {
        _productType = [[UILabel alloc] init];
        _productType.backgroundColor =RGBHex(0XFD8A30);
        _productType.textColor = WHITECOLOR;
        _productType.textAlignment =1;
        _productType.layer.cornerRadius =2.0;
        _productType.layer.masksToBounds =YES;
        _productType.font = DR_FONT(10);
        [self addSubview:_productType];
        [_productType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).offset(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(17));
           
        }];
        
    }
    return _productType;
}

-(UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = BLACKCOLOR;
        _productName.font = DR_FONT(14);
        [self addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType.mas_right).offset(WScale(5));
            make.top.mas_equalTo(self.productImg);
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(17));
        }];
    }
    return _productName;
}


-(UIView *)standardView
{
    if (!_standardView) {
        _standardView = [[UIView alloc] init];
        [self addSubview:_standardView];
        [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.productName.mas_bottom).offset(WScale(5));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(HeightF);
        }];
    }
    return _standardView;
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(280),WScale(12))];
        if (tagBtnX+tagTextSize.width+HScale(12) >WScale(250)) {
            
            tagBtnX = 0;
            tagBtnY += WScale(12)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(12));
        label.text = array[i];
        label.textColor = BLACKCOLOR;
        label.font = DR_FONT(12);
        label.textAlignment = 0;
//        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
//        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    HeightF = tagBtnY +WScale(12);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HeightF);
    }];
    
}

//-(UILabel *)cellLabel
//{
//    if (!_cellLabel) {
//        _cellLabel = [[UILabel alloc] init];
//        _cellLabel.textColor = BLACKCOLOR;
//        _cellLabel.font = DR_FONT(12);
//        _cellLabel.numberOfLines = 0;
//        [self addSubview:_cellLabel];
//        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.standardView.mas_bottom).offset(WScale(6.5));
//            make.left.mas_equalTo(self.productType);
//            make.right.mas_equalTo(WScale(-10));
//
//        }];
//    }
//    return _cellLabel;
//}

-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = RGBHex(0X888888);
        _parameterLabel.font = DR_FONT(11);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.standardView.mas_bottom).offset(WScale(6.5));
            make.left.mas_equalTo(self.productType);
            make.right.mas_equalTo(WScale(-10));
        }];
    }
    return _parameterLabel;
}
//-(UILabel *)countLabel
//{
//    if (!_countLabel) {
//        _countLabel = [[UILabel alloc] init];
//        _countLabel.textColor = RGBHex(0X888888);
//        _countLabel.font = DR_FONT(11);
//        _countLabel.numberOfLines = 0;
//        [self addSubview:_countLabel];
//        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(5));
//            make.left.mas_equalTo(self.productType);
//            make.right.mas_equalTo(WScale(-10));
//        }];
//    }
//    return _countLabel;
//}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = BLACKCOLOR;
        _moneyLabel.font = DR_FONT(12);
        _moneyLabel.numberOfLines = 0;
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(20));
            make.left.mas_equalTo(self.productType.mas_left);
            make.right.mas_equalTo(WScale(-10));
            make.bottom.mas_equalTo(WScale(-17));
        }];
    }
    return _moneyLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
