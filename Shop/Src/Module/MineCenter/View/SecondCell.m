//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "SecondCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"


#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度
#define HScale(v) v / 667. * kWindowH //高度比
#define WScale(w) w / 375. * kWindowW //宽度比
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation SecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr =titleStr;
    _nullImg.hidden =NO;
     self.moreBtn.hidden =NO;
}
-(void)setSameModel:(DRSameModel *)sameModel
{
    _sameModel =sameModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:sameModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =sameModel.itemName;
    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_right_grey" ]forState:UIControlStateSelected];
    
    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_down_grey" ]forState:UIControlStateNormal];
    self.moreBtn.backgroundColor =RGBHex(0X000000);
    //设置分组标题
    
    [self.moreBtn setTitle:@"更多信息"  forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起更多"  forState:UIControlStateSelected];
    
    [self.moreBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:0];
    self.moreBtn.hidden =YES;
    self.nullImg.hidden =NO;
    NSArray * array = @[sameModel.spec?:@"",sameModel.levelName?:@"",sameModel.materialName?:@"",sameModel.surfaceName?:@""];
    self.productType.text =sameModel.brandName;
    CGSize maximumLabelSize = CGSizeMake(100, 100);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.productType sizeThatFits:maximumLabelSize];
    [self.productType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(expectSize.width+WScale(13));
    }];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
    [self setStandWithArray:titArr.copy];
    
    NSString *baseStr;//basicUnitId 5千支  6公斤  7吨
    if ([sameModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([sameModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([sameModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    NSString *nameStr;
    if (sameModel.unitConversion1.length!=0&&![sameModel.unitConversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[sameModel.unitConversion1 doubleValue],baseStr,sameModel.unitName1];
    }
    if (sameModel.unitConversion2.length!=0&&![sameModel.unitConversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[sameModel.unitConversion2 doubleValue],baseStr,sameModel.unitName2];
    }
    if (sameModel.unitConversion3.length!=0&&![sameModel.unitConversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[sameModel.unitConversion3 doubleValue],baseStr,sameModel.unitName3];
    }
    if (sameModel.unitConversion4!=0&&![sameModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[sameModel.unitConversion4 doubleValue],baseStr,sameModel.unitName4];
    }
    if (sameModel.unitConversion5.length!=0&&![sameModel.unitConversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[sameModel.unitConversion5 doubleValue],baseStr,sameModel.unitName5];
    }
    
    self.parameterLabel.text =[NSString stringWithFormat:@"库存数(%@)：%.3f  发货地：%@",baseStr,sameModel.qty,sameModel.storeName];
    [SNTool setTextColor:self.parameterLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(self.parameterLabel.text.length-sameModel.storeName.length, sameModel.storeName.length) AndColor:REDCOLOR];
    self.cellLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
//    _nullImg.hidden =YES;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodsModel.itemName;
//    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_right_grey" ]forState:UIControlStateSelected];
//
//    [self.moreBtn setImage: [UIImage imageNamed: @"arrow_down_grey" ]forState:UIControlStateNormal];
//    self.moreBtn.backgroundColor =BLACKCOLOR;
//    //设置分组标题
//
//    [self.moreBtn setTitle:@"更多信息"  forState:UIControlStateNormal];
//    [self.moreBtn setTitle:@"收起更多"  forState:UIControlStateSelected];
//
//    [self.moreBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
//    [self.moreBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
//    self.moreBtn.hidden =NO;
    
    NSArray * array = @[goodsModel.spec?:@"",goodsModel.levelName?:@"",goodsModel.materialName?:@"",goodsModel.surfaceName?:@""];
    self.productType.text =goodsModel.brandName;
    
    CGSize maximumLabelSize = CGSizeMake(100, 100);//labelsize的最大值
    //关键语句
    CGSize expectSize = [self.productType sizeThatFits:maximumLabelSize];
    [self.productType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(expectSize.width+WScale(13));
    }];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    Height = WScale(30);
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
    NSString *nameStr;
    if (goodsModel.unitConversion1!=0) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",goodsModel.unitConversion1 ,baseStr,goodsModel.unitName1];
    }
    if (goodsModel.unitConversion2!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion2 ,baseStr,goodsModel.unitName2];
    }
    if (goodsModel.unitConversion3!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion3 ,baseStr,goodsModel.unitName3];
    }
    if (goodsModel.unitConversion4!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion4 ,baseStr,goodsModel.unitName4];
    }
    if (goodsModel.unitConversion5!=0) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",goodsModel.unitConversion5 ,baseStr,goodsModel.unitName5];
    }
    
    
    self.parameterLabel.text =[NSString stringWithFormat:@"库存数(%@)：%.3f  %@",baseStr,(float)goodsModel.qty,goodsModel.storeName];
     [SNTool setTextColor:self.parameterLabel FontNumber:DR_FONT(12) AndRange:NSMakeRange(self.parameterLabel.text.length-goodsModel.storeName.length, goodsModel.storeName.length) AndColor:REDCOLOR];
    if (nameStr) {
        
        self.cellLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
    }else
    {
        self.cellLabel.text =@"";
    }
  
    
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
//-(UIImageView *)nullImg
//{
//    if (!_nullImg) {
//        _nullImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot-ico"]];
//      
//        [self addSubview:_nullImg];
//        [_nullImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(WScale(5));
//            make.top.mas_equalTo(WScale(5));
//            make.width.height.mas_equalTo(WScale(15));
//        }];
//    }
//    return _nullImg;
//}
//-(UIButton *)moreBtn
//{
//    if (!_moreBtn) {
//        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _moreBtn.titleLabel.font =DR_FONT(11);
//
//        [self addSubview:_moreBtn];
//        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(_productImg);
//            make.top.mas_equalTo(_productImg.mas_bottom);
//            make.width.mas_equalTo(_productImg);
//            make.height.mas_equalTo(WScale(25));
//
//        }];
//    }
//    return _moreBtn;
//}


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
            make.height.mas_equalTo(Height);
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
        if (tagBtnX+tagTextSize.width+WScale(12) >WScale(250)) {
            
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
        if (i==0) {
            [SNTool setTextColor:label FontNumber:DR_FONT(12) AndRange:NSMakeRange(0, label.text.length) AndColor:REDCOLOR];
        }
    }
    Height = tagBtnY +WScale(12);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Height);
    }];
}

-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = BLACKCOLOR;
        _parameterLabel.font = ZF_FONT(12);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.standardView.mas_bottom).offset(WScale(10));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(12));

        }];
    }
    return _parameterLabel;
}

-(UILabel *)cellLabel
{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textColor = RGBHex(0X888888);
        _cellLabel.font = ZF_FONT(11);
        _cellLabel.numberOfLines = 0;
        [self addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).offset(WScale(7));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(12));
            make.bottom.mas_equalTo(WScale(-10));
        }];
    }
    return _cellLabel;
}

-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = BLACKCOLOR;
        _countLabel.font = ZF_FONT(11);
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.cellLabel.mas_bottom).offset(WScale(7));
            make.right.mas_equalTo(WScale(-5));
           
        }];
    }
    return _countLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
